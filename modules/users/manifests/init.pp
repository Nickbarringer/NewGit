class users{

  user { 'arthur':
    ensure  => present,
    comment => 'just arthur',
    gid   => 'staff',
    shell   => '/bin/bash',
  }
   group { 'staff':
     ensure => present,

  }
}

