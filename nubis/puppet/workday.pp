cron::daily { "${project_name}-workday":
  hour    => '1',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-workday /opt/ltv/workday/fetch",
}

cron::daily { "${project_name}-workday-plus":
  hour    => '5',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-workday-plus /opt/ltv/workday/fetch_plus",
}

file { '/opt/ltv/workday':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/workday':
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

file { '/opt/ltv/workday/workday.py':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0644',
  require => [
    File['/opt/ltv/workday'],
  ],
  source  => 'puppet:///nubis/files/workday/workday.py',
}

file { '/opt/ltv/workday/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/workday'],
  ],
  source  => 'puppet:///nubis/files/workday/fetch_workday_data.py',
}

file { '/opt/ltv/workday/fetch_plus':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/workday'],
  ],
  source  => 'puppet:///nubis/files/workday/fetch_workday_data_plus.py',
}
