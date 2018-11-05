cron::weekly { "${project_name}-peopleteam-dashboard":
  user    => 'ltv',
  command => "nubis-cron ${project_name}-peopleteam_dashboard /opt/ltv/peopleteam_dashboard/run",
  hour    => 16,
  weekday => 6,
}

file { '/usr/local/bin/peopleteam-dashboard-fetcher':
  ensure  => link,
  target  => "${virtualenv_path}/data-integrations/bin/get_people_dashboard_data.py",
  require => [
    Python::Pip['data-integrations'],
  ],
}

file { '/opt/ltv/peopleteam_dashboard':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/peopleteam_dashboard':
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

file { '/opt/ltv/peopleteam_dashboard/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard/fetch.sh',
}

file { '/opt/ltv/peopleteam_dashboard/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard/load.sh',
}

file { '/opt/ltv/peopleteam_dashboard/load.yml':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard/load.yml',
}

file { '/opt/ltv/peopleteam_dashboard/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/peopleteam_dashboard'],
  ],
  source  => 'puppet:///nubis/files/peopleteam_dashboard/run.sh',
}
