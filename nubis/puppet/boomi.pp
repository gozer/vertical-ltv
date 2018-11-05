package { 'python36':
  ensure => present,
}

package { 'python36-devel':
  ensure => present,
}

class { 'mysql::bindings':
  daemon_dev => true,
}

python::pyvenv { "${virtualenv_path}/boomi" :
  ensure  => present,
  version => '3.6',
  require => [
    Package['python36'],
    Package['python36-devel'],
    File[$virtualenv_path],
  ],
}

file { '/opt/ltv/boomi':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/boomi':
  ensure  => directory,
  owner   => 'ltv',
  group   => 'ltv',
  mode    => '0755',

  require => [
    User['ltv'],
    Group['ltv'],
    File['/var/lib/ltv'],
  ]
}

# Install Mozilla boomi python libraries 
python::pip { 'mozilla_etl':
  ensure     => 'present',
  virtualenv => "${virtualenv_path}/boomi",
  url        => 'git+https://github.com/gozer/mozilla_etl.git',
  require    => [
      Class['mysql::bindings'],
  ],
}
