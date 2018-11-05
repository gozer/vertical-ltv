# holding user for all jobs

group { 'ltv':
  ensure => present,
  system => true,
  gid    => 991,
}

user { 'ltv':
  ensure     => present,
  system     => true,
  gid        => 'ltv',
  uid	     => 994,
  managehome => true,
}

file { '/home/ltv/.ssh':
  ensure => 'directory',
  mode   => '0700',
  require => [
    User['ltv'],
    Group['ltv'],
  ]
}

file { '/var/lib/ltv':
  ensure => 'directory',
}

file { '/opt/ltv':
  ensure => directory,
}

# Temporary holding location for data-collectors

file { '/var/data-collectors':
  ensure  => directory,
  owner   => 'ltv',
  group   => 'ltv',
  mode    => '0755',

  require => [
    User['ltv'],
    Group['ltv'],
  ]
}

file { '/home/ltv/.ssh':
  ensure  => directory,
  owner   => 'ltv',
  group   => 'ltv',
  mode    => '0700',

  require => [
    User['ltv'],
    Group['ltv'],
  ]
}

# Cleanup and archive data files
cron::daily { "${project_name}-snapshot":
  hour    => '6',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-snapshot /usr/local/bin/nubis-ltv-snapshot save",
}
