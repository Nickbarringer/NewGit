class apache{

  package { 'httpd':
    ensure => present,
  }
  file { '/var/www':
    ensure  => directory,
  }
  file { '/var/www/html':
    ensure => directory,
  }
  file {'/var/www/html/index.html':
    ensure  => file,
    source => 'puppet:///modules/apache/index.html',
  }
  file {'/etc/httpd/conf/httpd.conf':
    ensure => file,
    require => Package['httpd'],
  }
  service { 'httpd':
    ensure => running,
    subscribe => File['/etc/httpd/conf/httpd.conf'],
  }
}
