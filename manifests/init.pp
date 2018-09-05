# How to launch:
#  /opt/puppetlabs/puppet/bin/puppet apply \
#  --debug --modulepath=/etc/puppetlabs/code/environments/production/modules/ -e "include aixautomation"
# This will trigger this suma command:
#  /usr/sbin/suma -x  -a RqType=SP -a RqName=7200-01-03-1720 -a FilterML=7200-01-02-1717 \
#   -a DisplayName="Downloading lppsources into /tmp/lpp_sources/SP/7200-01-02-1717/7200-01-03-1720" \
#   -a Action=Preview -a DLTarget=/tmp/lpp_sources/SP/7200-01-02-1717/7200-01-03-1720 \
#   -a FilterDir=/tmp/lpp_sources/SP/7200-01-02-1717/7200-01-03-1720
class aixautomation {
  # vios { 'vios0':
  #   ensure  => present,
  #   name => 'vios0',
  #   vios_pairs => '(castor_gdr_vios1,castor_gdr_vios2), (castor_gdr_vios2,castor_gdr_vios3)',
  #   actions => 'check',
  # }
  vios { 'vios11':
    ensure               => present,
    name                 => 'vios',
    # actions => 'check,save,update',
    actions              => 'check, save, update',
    update_options       => 'accept_licenses, commit',
    vios_pairs           => '(p7juav1,p7juav2)',
    altinst_rootvg_force => 'yes',
    vios_lpp_sources     => 'p7juav1=vios_update,p7juav2=vios_update_22621',
  }
  # vios { 'vios12':
  #   ensure  => present,
  #   name => 'vios12',
  #   # alt_disks => 'p7juav1:hdisk0;p7juav1:hdisk1;p7juav1:hdisk2;p7juav1:hdisk3;p7juav1:hdisk4;p7juav1:hdisk5;p7juav2:hdisk0;p7juav2:hdisk1;;p7juav2:hdisk2',
  #   vios => 'p7juav1:p7juav2',
  #   actions => 'save',
  # }
  # vios { 'vios2':
  #   ensure  => present,
  #   name => 'vios2',
  #   vios_pairs => '(quimby-vios1,quimby-vios2)',
  #   actions => 'status',
  # }
  # vios { 'vios3':
  #   ensure  => present,
  #   name => 'vios3',
  #   vios_pairs => '(p7juav1,p7juav2)',
  #   actions => 'status',
  # }
  # download { "test suma1":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01-01-1141",
  #   to      => "7100-01-02-1150",
  #   to_step => "download",
  # }
  # download { "test suma2":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01",
  #   to      => "7100-01-02-1150",
  #   to_step => "download",
  # }
  # download { "test suma3":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01-02-1150",
  #   to      => "7100-01-04-1216",
  #   to_step => "download",
  # }
  # download { "test suma4":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01",
  #   to      => "7100-01-04-1216",
  #   to_step => "download",
  # }
  # download { "test suma5":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01-04-1216",
  #   to      => "7100-01-07-1316",
  #   to_step => "download",
  # }
  # download { "test suma6":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01",
  #   to      => "7100-01-07-1316",
  #   to_step => "download",
  # }
  # download { "test suma7":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01-07-1316",
  #   to      => "7100-01-09-1341",
  #   to_step => "download",
  # }
  # download { "test suma8":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01",
  #   to      => "7100-01-09-1341",
  #   to_step => "download",
  # }
  # download { "test suma10":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01-01-1141",
  #   to      => "7100-02-01-1245",
  #   to_step => "download",
  # }
  # download { "test suma11":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01",
  #   to      => "7100-02-01-1245",
  #   to_step => "download",
  # }
  # download { "test suma12":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01-02-1150",
  #   to      => "7100-02-02-1316",
  #   to_step => "download",
  # }
  # download { "test suma13":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01",
  #   to      => "7100-02-02-1316",
  #   to_step => "download",
  # }
  # download { "test suma14":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01-07-1316",
  #   to      => "7100-02-07-1524",
  #   to_step => "download",
  # }
  # download { "test suma15":
  #   ensure  => present,
  #   type    => "SP",
  #   # /tmp should be changed to perform a 'download' to a more appropriate
  #   #  directory in dedicated file system.
  #   # No need to change it to perform a 'preview'
  #   root    => "/tmp/test",
  #   from    => "7100-01",
  #   to      => "7100-02-07-1524",
  #   to_step => "download",
  # }
}