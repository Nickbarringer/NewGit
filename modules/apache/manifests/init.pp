class apache{
  

  case $::osfamily { 
    'RedHat': {$httpd_user="apache" 
               $httpd_group="apache"
               $httpd_pkg="httpd"
               $httpd_svc="httpd"
               $httpd_conf="/etc/httpd/conf/httpd.conf"
               $httpd_conf_dot_d='/etc/httpd/conf.d'
    }
    'Debian': {$httpd_user="www-data"
               $httpd_group="www-data"
               $httpd_pkg="apache2"
               $httpd_svc="apache2"
               $httpd_conf="/etc/apache2/conf/httpd.conf"
               $httpd_conf_dot_d='/etc/apache2/conf.d'
    }
    default:  {fail("no suuport on this OS")}
  }

File  {
    owner => $httpd_user,
    group => $httpd_group,
    mode  => '0644',
}
  package { 'httpd_pkg':
    ensure => present,
  }
  file { '/var/www':
    ensure  => directory,
  }
  file { '/var/www/html':
    ensure => directory,
  }
  file {'/var/www/html/index.html':
    content => template('apache/index.html.erb'),
  }
  file {$httpd_conf:
    ensure  => file,
    require => Package[$httpd_pkg],
    owner   => $httpd_user,
    source  => 'puppet:///modules/apache/httpd.conf',
    group   => $httpd_group
  }
  service { 'httpd':
    ensure => running,
    subscribe => File[$httpd_conf],
  }
}
