cron::weekly { "${project_name}-ltv":
  weekday => '3',
  hour    => '3',
  minute  => '00',
  user    => 'ltv',
  command => "nubis-cron ${project_name}-ltv /opt/ltv/ltv/run",
}

python::virtualenv { "${virtualenv_path}/ltv" :
  ensure      => present,
  virtualenv  => 'virtualenv',
  environment => [
    'VIRTUALENV_PYTHON=python2.7',
  ],
  require     => [
    File[$virtualenv_path],
  ],
}

file { '/opt/ltv/ltv':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/ltv':
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

# Install ltv python libraries 
python::requirements { 'ltv':
  requirements => '/opt/ltv/ltv/requirements.txt',
  forceupdate  => true,
  virtualenv   => "${virtualenv_path}/ltv",
  require      => [
    Python::Virtualenv["${virtualenv_path}/ltv"],
    File['/opt/ltv/ltv/requirements.txt'],
  ],
}

file { '/opt/ltv/ltv/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/fetch.sh',
}

file { '/opt/ltv/ltv/util.py':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/util.py',
}

file { '/opt/ltv/ltv/requirements.txt':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0644',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/requirements.txt',
}

file { '/opt/ltv/ltv/load_client_details':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/load_client_details.py',
}

file { '/opt/ltv/ltv/load_search_history':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/load_search_history.py',
}

file { '/opt/ltv/ltv/ltv_calc_v1':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/ltv_calc_v1.py',
}

file { '/opt/ltv/ltv/test_ltv_calc_v1':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/test_ltv_calc_v1.py',
}

file { '/opt/ltv/ltv/ltv_aggr_v1':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/ltv_aggr_v1.py',
}

file { '/opt/ltv/ltv/create_files':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/create_files.py',
}

file { '/opt/ltv/ltv/push_to_gcp':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/push_to_gcp.sh',
}

file { '/opt/ltv/ltv/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/ltv'],
  ],
  source  => 'puppet:///nubis/files/ltv/run.sh',
}
