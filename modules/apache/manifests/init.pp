class apache{
  
  case $::operatingsystem { 
    'centos': {$httpd_user="apache" 
               $httpd_group="apache"
               $httpd_pkg="httpd"
               $httpd_svc="httpd"
               $httpd_conf="/etc/httpd/conf/httpd.conf"
    }
    'debian': {$httpd_user="www-data"
               $httpd_group="www-data"
               $httpd_pkg="apache2"
               $httpd_svc="apache2"
               $httpd_conf="/etc/apache2/httpd.conf"
    }
    default:  {fail("no suuport on this OS")}
  }

File  {
    owner => $httpd_user,
    group => $httpd_group,
    mode  => '0644',
}
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
  file {$httpd_conf:
    ensure  => file,
    require => Package[$httpd_pkg],
    owner   => $httpd_user,
    group   => $httpd_group
  }
  service { 'httpd':
    ensure => running,
    subscribe => File[$httpd_conf],
  }
}
