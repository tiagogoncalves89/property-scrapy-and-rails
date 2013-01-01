class rails {

  package { ['ruby1.9.3', 'libmysqlclient-dev', 'nodejs']:
    ensure => present,
    require => Exec['apt-get update']
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
    cwd => '/vagrant/ror_imoveis',
    logoutput => true,
    user => 'vagrant'
  } ->

  exec { 'rake db':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    unless => '/usr/bin/mysql -u root wp_imoveis_development',
    command => 'rake db:create && rake db:migrate && rake db:test:prepare',
    cwd => '/vagrant/ror_imoveis',
    logoutput => true,
    user => 'vagrant'
  } ->

  exec { 'rails server':
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin',
    command => 'nohup rails s > /dev/null 2>&1 &',
    cwd => '/vagrant/ror_imoveis',
    logoutput => true,
    user => 'vagrant'
  }

}