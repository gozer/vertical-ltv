cron::daily { "${project_name}-xmatters":
  user    => 'ltv',
  command => "nubis-cron ${project_name}-xmatters /opt/ltv/xmatters/run",
}

file { '/usr/local/bin/xmatters_sync':
  ensure  => link,
  target  => "${virtualenv_path}/data-integrations/bin/xmatters_poc.py",
  require => [
    Python::Pip['data-integrations'],
  ],
}

file { '/opt/ltv/xmatters':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/opt/ltv/xmatters/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/xmatters'],
  ],
  source  => 'puppet:///nubis/files/xmatters/run.sh',
}
