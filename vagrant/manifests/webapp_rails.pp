class webapp_rails {

  package { ['ruby1.9.3', 'libmysqlclient-dev', 'nodejs']:
    ensure => present,
    require => Exec['apt-get upgrade']
  } ->

  exec { 'install rails':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'gem install rails --install-dir=/var/lib/gems/1.9.1',
    timeout => 0,
    logoutput => true
  } ->

  exec { 'bundle install':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'bundle install --path=/home/vagrant',
    cwd => '/project',
    logoutput => true,
    user => 'vagrant'
  } ->

  exec { 'rake db':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    unless => '/usr/bin/mysql -u root ror_imoveis_development',
    command => 'rake db:create && rake db:migrate && rake db:seed && rake db:test:prepare',
    cwd => '/project',
    logoutput => true,
    user => 'vagrant',
    require => Service['mysql']
  } ->

  exec { 'rails server':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'nohup rails s > /dev/null 2>&1 &',
    cwd => '/project',
    logoutput => true,
    user => 'vagrant'
  }

}