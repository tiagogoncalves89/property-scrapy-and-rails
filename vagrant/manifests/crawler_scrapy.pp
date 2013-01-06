class crawler_scrapy {

	package { ['python-pip', 'python-dev', 'libxml2-dev', 'libxslt-dev', 'python-mysqldb']:
		ensure => present,
		require => Exec['apt-get update']
	} ->

	exec { 'install scrapy':
		command => '/usr/bin/pip install scrapy'
	}

}