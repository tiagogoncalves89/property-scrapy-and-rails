class base {
	group { 'puppet':
	  ensure => 'present'
	}

	exec { 'apt-get update':
	  command => '/usr/bin/apt-get update'
	} ->

	package { 'vim':
	  ensure => present
	}
}