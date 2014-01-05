exec { "config":
  command => "config.sh",
    path => "/vagrant/scripts",
    logoutput => true, 
}
