$CLONE_URL = "https://github.com/jonathancroke/herc-storm-puppet.git"
$CHECKOUT_DIR="/tmp/herc-storm-puppet"

package {git:ensure=> [latest,installed]}
package {puppet:ensure=> [latest,installed]}
package {ruby:ensure=> [latest,installed]}
package {rubygems:ensure=> [latest,installed]}
package {unzip:ensure=> [latest,installed]}
package {curl:ensure=> [latest,installed]}

notify { 'Installing Hiera': }
exec { "install_hiera":
  command => "sudo gem install hiera hiera-puppet",
    path => "/usr/bin",
    require => Package['rubygems'],
}

notify { 'Cloning Herc-Storm-Puppet': }
exec { "clone_storm-puppet":
  command => "git clone ${CLONE_URL}",
  cwd => "/tmp",
    path => "/usr/bin",
    creates => "${CHECKOUT_DIR}",
    require => Package['git'],
}

exec {"/bin/ln -s /var/lib/gems/1.8/gems/hiera-puppet-1.0.0/ /tmp/herc-storm-puppet/modules/hiera-puppet":
  creates => "/tmp/herc-storm-puppet/modules/hiera-puppet",
  require => [Exec['clone_storm-puppet'],Exec['install_hiera']]
}

#install hiera and the storm configuration 
file { "/etc/puppet/hiera.yaml":
    source => "/vagrant_data/hiera.yaml",
    replace => true,
    require => Package['puppet']
}

file { "/etc/puppet/hieradata":
  ensure => directory,
  require => Package['puppet'] 
}

file {"/etc/puppet/hieradata/storm.yaml": 
  source => "${CHECKOUT_DIR}/modules/storm.yaml",
    replace => true,
    require => [Exec['clone_storm-puppet'],File['/etc/puppet/hieradata']]
}
