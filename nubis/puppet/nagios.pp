cron::daily { "${project_name}-nagios":
  hour    => '7',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-nagios /opt/ltv/nagios/run",
}

file { '/opt/ltv/nagios':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/nagios':
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

file { '/opt/ltv/nagios/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/nagios'],
  ],
  source  => 'puppet:///nubis/files/nagios/fetch.sh',
}

file { '/opt/ltv/nagios/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/nagios'],
  ],
  source  => 'puppet:///nubis/files/nagios/load.py',
}

file { '/opt/ltv/nagios/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/nagios'],
  ],
  source  => 'puppet:///nubis/files/nagios/run.sh',
}
