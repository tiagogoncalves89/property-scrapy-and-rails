class webapp_mysql {
  
  package { 'mysql-server':
    ensure => present,
    require => Exec['apt-get update']
  } ->

  file { 'my.cnf':
    path => '/etc/mysql/my.cnf',
    source => '/vagrant/files/my.cnf',
    notify => Service['mysql']
  } ->

  service { 'mysql':
    ensure => running
  } ->

  exec { 'grant permissions':
    command => "/usr/bin/mysql -u root -e \"grant all on *.* to 'root'@'%' WITH GRANT OPTION;FLUSH PRIVILEGES;\""
  }

}