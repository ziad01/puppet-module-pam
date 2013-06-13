# # Class: pam::limits::fragment #
#
# Places a fragment in $limits_d_dir directory
#
# ## Parameters ##
#
# source
# ------
# Path to the fragment file
#
# - *Required*
#
# ## Example usage ##
# # Add the file example.conf in the pam module to the limits_d_dir with the name "91-users-nproc.conf"
# pam::limits::fragment { '91-users-nproc':
#        fragment_content => join(hiera_array("limits"), "\n"),
# }
#
define pam::limits::fragment ( 
  $fragment_content,
) {

  include pam
  include pam::limits

  file { "${pam::limits::limits_d_dir}":
    ensure    => 'directory', 
    recurse   => true, 
    purge     => true, 
  } 

  file { "${pam::limits::limits_d_dir}/${name}.conf":
    content => $fragment_content,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['pam_package'],
  }
}
