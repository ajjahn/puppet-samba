# Class: samba::params
#
# This class defines default parameters used by the main module class samba
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to samba class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class samba::params {
  $services = $::osfamily ? {
    /(?i:RedHat)/ => 'smb',
    /(?i:Debian)/ => 'smbd',
    /(?i:Gentoo)/ => 'samba',
    /(?i:Suse)/   => ['smb','nmb'],
    default       => 'smbd',
  }

  $samba_config_dir  = '/etc/samba'
  $samba_config_file = '/etc/samba/smb.conf'
  $lense             = 'Samba.lns'
}


