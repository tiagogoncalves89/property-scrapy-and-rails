group { 'puppet':
  ensure => 'present'
}

exec { 'apt-get update':
  command => '/usr/bin/apt-get update',
  require => Group['puppet']
}

package { 'vim':
  ensure => present,
  require => Exec['apt-get update']
}

class mysql {
  
  package { 'mysql-server':
    ensure => present,
    require => Exec['apt-get update']
  }

  exec { 'my.cnf':
    command => '/bin/cp /project/vagrant/my.cnf /etc/mysql/my.cnf',
    require => Package['mysql-server']
  }

  service { 'mysql':
    ensure => running,
    require => Exec['my.cnf']
  }

  exec { 'grant permissions':
    command => "/usr/bin/mysql -u root -e \"grant all on *.* to 'root'@'%' WITH GRANT OPTION;\"",
    logoutput => true,
    require => Service['mysql']
  }

  exec { 'mysql restart':
    command => '/etc/init.d/mysql restart'
  }

}

class rails {

  package { ['ruby1.9.3', 'libmysqlclient-dev', 'nodejs']:
    ensure => present,
    require => Exec['apt-get update']
  }

  exec { 'install rails':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'gem install rails --install-dir=/var/lib/gems/1.9.1',
    timeout => 0,
    logoutput => true,
    require => Package['ruby1.9.3']
  }

  exec { 'bundle install':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'bundle install --path=/home/vagrant',
    cwd => '/project',
    logoutput => true,
    user => 'vagrant',
    require => [Exec['install rails'], Package['ruby1.9.3'], Package['libmysqlclient-dev']]
  }

  exec { 'rake db':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'rake db:create && rake db:migrate && rake db:test:prepare',
    cwd => '/project',
    logoutput => true,
    user => 'vagrant',
    require => [Exec['bundle install'], Package['nodejs']]
  }

  exec { 'rails server':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'nohup rails s > /dev/null 2>&1 &',
    cwd => '/project',
    logoutput => true,
    user => 'vagrant',
    require => [Exec['bundle install'], Package['nodejs']]
  }

}

include mysql
include rails