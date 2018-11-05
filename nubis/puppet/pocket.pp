cron::daily { "${project_name}-pocket":
  hour    => '10',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-pocket /opt/ltv/pocket/run",
}

file { '/opt/ltv/pocket':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/pocket':
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

file { '/opt/ltv/pocket/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/pocket'],
  ],
  source  => 'puppet:///nubis/files/pocket/fetch.sh',
}

file { '/opt/ltv/pocket/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/pocket'],
  ],
  source  => 'puppet:///nubis/files/pocket/load.py',
}

file { '/opt/ltv/pocket/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/pocket'],
  ],
  source  => 'puppet:///nubis/files/pocket/run.sh',
}
