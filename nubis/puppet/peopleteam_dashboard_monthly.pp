cron::monthly { "${project_name}-peopleteam-dashboard-monthly":
  user    => 'ltv',
  command => "nubis-cron ${project_name}-peopleteam_dashboard_monthly /opt/ltv/peopleteam_dashboard_monthly/run",
  date    => 1,
  hour    => 16,
}

file { '/opt/ltv/peopleteam_dashboard_monthly':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/peopleteam_dashboard_monthly':
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

file { '/opt/ltv/peopleteam_dashboard_monthly/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard_monthly'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard_monthly/fetch.sh',
}

file { '/opt/ltv/peopleteam_dashboard_monthly/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard_monthly'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard_monthly/load.sh',
}

file { '/opt/ltv/peopleteam_dashboard_monthly/load.yml':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard_monthly'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard_monthly/load.yml',
}

file { '/opt/ltv/peopleteam_dashboard_monthly/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard_monthly'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard_monthly/run.sh',
}
