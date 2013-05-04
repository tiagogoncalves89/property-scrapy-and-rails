class webapp_mysql {

  package { 'mysql-server':
    ensure  => present,
    require => Exec['apt-get update']
  } ->

  file { 'my.cnf':
    path   => '/etc/mysql/my.cnf',
    source => '/tmp/vagrant-puppet/files/my.cnf',
    notify => Service['mysql'],
    owner  => 'root',
    group  => 'root',
    mode   => '0644'
  } ->

  service { 'mysql':
    ensure => running
  } ->

  exec { 'grant permissions to root':
    command => "/usr/bin/mysql -u root -e \"grant all on *.* to 'root'@'%' WITH GRANT OPTION;FLUSH PRIVILEGES;\""
  } ->

  exec { 'grant permissions to vagrant':
    command => "/usr/bin/mysql -u root -e \"grant all on *.* to 'vagrant'@'localhost' WITH GRANT OPTION;FLUSH PRIVILEGES;\""
  }

}