require_relative '../../puppet_x/Automation/Lib/Utils.rb'
require_relative '../../puppet_x/Automation/Lib/Suma.rb'
require_relative '../../puppet_x/Automation/Lib/SpLevel.rb'

# ##########################################################################
# name : download type
# description : this custom type enables to automate download through
#  suma metadata/preview/download
# ##########################################################################
Puppet::Type.newtype(:download) do
  @doc = 'To manage all simple download functions.'
  feature :download, 'The ability to manage simple download actions.', \
:methods => [:download]

  include Automation::Lib

  # ############################################################################
  #
  # ############################################################################
  ensurable do
    defaultvalues
    defaultto :present
  end

  # ############################################################################
  #
  ##############################################################################
  newparam(:name, :namevar => true) do
  end

  # ############################################################################
  # :root is the download root directory
  # ############################################################################
  newparam(:root) do
    desc '"root" parameter: download root directory for updates'
    validate do |value|
      raise('"root" needs to exist') if Utils.check_directory(value) == -1
    end
  end

  # ############################################################################
  # :type is the type of suma download desired
  #
  # Check :type against a short list, provide a default
  # ############################################################################
  newparam(:type) do
    desc '"type" parameter: either "SP", "TL", "Latest", or "Meta"'
    defaultto :SP
    newvalues(:SP, :TL, :Latest, :Meta)
  end

  # ############################################################################
  # :lpp_source is the name of the NIM resource lpp_source built at the end
  #  of suma download. If ever it is not provided, a default value is generated
  #  with naming convention "PAA_<type>_<from>_<to>"
  # ############################################################################
  newparam(:lpp_source) do
    desc '"lpp_source" parameter: optional parameter, \
name of the lpp_source built, by default "PAA_<type>_<from>_<to>"'
    defaultto ''
  end

  # ############################################################################
  # :from is a parameter of the suma request, giving current level of the system
  # ############################################################################
  newparam(:from) do
    desc '"from" parameter: current level'
    defaultto ''
  end

  # ############################################################################
  # :to is a parameter of the suma request, giving desired level of the system
  # ############################################################################
  newparam(:to) do
    desc '"to" parameter: desired level'
    defaultto ''
  end

  # ############################################################################
  #
  # ############################################################################
  newparam(:to_step) do
    desc '"to_step" parameter possible values: "preview", "download"'
    defaultto :download
    newvalues(:preview, :download)
  end


  # ############################################################################
  # :clean parameter to
  #
  # Check :clean against a short list, provide a default
  # ############################################################################
  newparam(:clean) do
    desc '"clean" parameter: possible values "yes", "no"'
    defaultto :no
    newvalues(:yes, :no)
  end

  # ############################################################################
  # Perform global consistency checks between parameters
  # ############################################################################
  validate do

    # validate directories
    dir_metadata = ::File.join(self[:root], 'metadata', self[:from])
    raise(dir_metadata + ' needs to exist') if Utils.check_directory(dir_metadata) == -1

    dir_lppsource = ::File.join(self[:root], 'lpp_sources')
    raise(dir_lppsource + ' needs to exist') if Utils.check_directory(dir_lppsource) == -1

    from = self[:from]
    to = self[:to]

    if self[:type] == :SP

      result = SpLevel.validate_sp_tl('from', from)
      raise('"' + from + '" "from" parameter is invalid') unless result

      result = SpLevel.sp_tl_exists(from)
      raise('"' + from + '" "from" parameter is neither a known TL nor a known SP') unless result

      result = SpLevel.validate_sp('to', to)
      raise('"' + to + '" "to" parameter is invalid') unless result

      result = SpLevel.sp_exists(to)
      raise('"' + to + '" "to" parameter is not a known SP') unless result

    elsif self[:type] == :TL

      result = SpLevel.validate_tl('from', from)
      raise('"' + from + '" "from" parameter is invalid') unless result

      # result = SpLevel.validate_sp_tl("to", to)
      result = SpLevel.validate_tl('to', to)
      raise('"' + to + '" "to" parameter is invalid') unless result

      result = SpLevel.tl_exists(from)
      raise('"' + from + '" "from" parameter is not a known TL') unless result
      result = SpLevel.tl_exists(to)
      raise('"' + to + '" "to" parameter is not a known TL') unless result

    elsif self[:type] == :Latest

      result = SpLevel.validate_tl('from', from)
      raise('"' + from + '" "from" parameter is invalid') unless result

      raise('"' + to + '" "to" parameter must not be specified for Latest') if to != ''

      result = SpLevel.tl_exists(from)
      raise('"' + from + '" "from" parameter is not a known TL') unless result
    end
  end
end