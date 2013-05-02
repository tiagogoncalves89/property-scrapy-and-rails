class webapp_rails {

  package { ['ruby1.9.3', 'libmysqlclient-dev', 'nodejs', 'build-essential']:
    ensure  => present,
    require => Exec['apt-get update']
  } ->

  exec { 'install bundler':
    command   => '/usr/bin/gem install bundler',
    timeout   => 0,
    logoutput => true
  } ->

  exec { 'bundle install':
    command   => '/usr/local/bin/bundle install --path=/home/vagrant',
    cwd       => '/vagrant/webapp',
    logoutput => true,
    user      => 'vagrant'
  } ->

  exec { 'rake db':
    path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/tmp/vagrant-puppet/files_ruby/bin',
    unless    => 'mysql -u root ror_imoveis_development',
    command   => 'bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed && bundle exec rake db:test:prepare',
    cwd       => '/vagrant/webapp',
    logoutput => true,
    user      => 'vagrant',
    require   => Service['mysql']
  } ->

  exec { 'rails server':
    path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/tmp/vagrant-puppet/files_ruby/bin',
    command   => '/usr/bin/nohup bundle exec rails s > /dev/null 2>&1 &',
    cwd       => '/vagrant/webapp',
    logoutput => true,
    user      => 'vagrant'
  }

}