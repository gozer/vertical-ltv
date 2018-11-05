cron::daily { "${project_name}-search-daily":
  hour    => '15',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-search-daily /opt/ltv/search/run -s daily",
}

cron::monthly { "${project_name}-search-monthly":
  hour    => '15',
  minute  => fqdn_rand(60),
  date    => '2',
  user    => 'ltv',
  command => "nubis-cron ${project_name}-search-monthly /opt/ltv/search/run -s monthly",
}

file { '/opt/ltv/search':
  ensure  => directory,
  owner   => 'ltv',
  group   => 'ltv',
  require => [
    User['ltv'],
    Group['ltv'],
    File['/opt/ltv'],
  ],
}

file { '/var/lib/ltv/search':
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

file { '/opt/ltv/search/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/search'],
  ],
  source  => 'puppet:///nubis/files/search/fetch.sh',
}

file { '/opt/ltv/search/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/search'],
  ],
  source  => 'puppet:///nubis/files/search/load.sh',
}

file { '/opt/ltv/search/load-daily':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/search'],
  ],
  source  => 'puppet:///nubis/files/search/load-daily.py',
}

file { '/opt/ltv/search/load-monthly':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/search'],
  ],
  source  => 'puppet:///nubis/files/search/load-monthly.py',
}

file { '/opt/ltv/search/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/search'],
  ],
  source  => 'puppet:///nubis/files/search/run.sh',
}
