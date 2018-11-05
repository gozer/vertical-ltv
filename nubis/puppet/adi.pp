cron::daily { "${project_name}-adi":
  hour    => '14',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-adi /opt/ltv/adi/run",
}

file { '/opt/ltv/adi':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/adi':
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

file { '/opt/ltv/adi/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/adi'],
  ],
  source  => 'puppet:///nubis/files/adi/fetch.sh',
}

file { '/opt/ltv/adi/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/adi'],
  ],
  source  => 'puppet:///nubis/files/adi/load.py',
}

file { '/opt/ltv/adi/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/adi'],
  ],
  source  => 'puppet:///nubis/files/adi/run.sh',
}
