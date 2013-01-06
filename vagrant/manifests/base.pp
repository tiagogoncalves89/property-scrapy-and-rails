class base {
	group { 'puppet':
	  ensure => 'present'
	}

	exec { 'apt-get update':
	  command => '/usr/bin/apt-get update'
	} ->

  exec { 'apt-get upgrade':
    command => '/usr/bin/apt-get upgrade -y'
  } ->

	package { 'vim':
	  ensure => present
	}
}