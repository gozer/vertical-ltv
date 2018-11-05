cron::weekly { "${project_name}-churn":
  weekday => '3',
  hour    => '21',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-churn /opt/ltv/churn/run",
}

file { '/opt/ltv/churn':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/churn':
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

file { '/opt/ltv/churn/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/churn'],
  ],
  source  => 'puppet:///nubis/files/churn/fetch.sh',
}

file { '/opt/ltv/churn/call_load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/churn'],
  ],
  source  => 'puppet:///nubis/files/churn/call_load.sh',
}

file { '/opt/ltv/churn/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/churn'],
  ],
  source  => 'puppet:///nubis/files/churn/load.py',
}

file { '/opt/ltv/churn/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/churn'],
  ],
  source  => 'puppet:///nubis/files/churn/run.sh',
}
