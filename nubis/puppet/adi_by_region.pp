cron::monthly { "${project_name}-adi_by_region":
  date    => '2',
  hour    => '1',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-adi /opt/ltv/adi_by_region/run",
}

file { '/opt/ltv/adi_by_region':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/adi_by_region':
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

file { '/opt/ltv/adi_by_region/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/adi_by_region'],
  ],
  source  => 'puppet:///nubis/files/adi_by_region/fetch.sh',
}

file { '/opt/ltv/adi_by_region/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/adi_by_region'],
  ],
  source  => 'puppet:///nubis/files/adi_by_region/load.py',
}

file { '/opt/ltv/adi_by_region/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/adi_by_region'],
  ],
  source  => 'puppet:///nubis/files/adi_by_region/run.sh',
}
