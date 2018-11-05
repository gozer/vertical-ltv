cron::daily { "${project_name}-salesforce_sfmc":
  user    => 'ltv',
  command => "nubis-cron ${project_name}-salesforce_sfmc /opt/ltv/salesforce_sfmc/run",
  hour    => 18,
}

python::pyvenv { "${virtualenv_path}/data-integrations" :
  ensure  => present,
  version => '3.4',
  require => [
    File[$virtualenv_path],
  ],
}

# Install Mozilla's data-integrations
python::pip { 'data-integrations':
  ensure     => 'present',
  virtualenv => "${virtualenv_path}/data-integrations",
  url        => 'git+https://github.com/mozilla-it/data-integrations@8fcfe2b3af71fb7651e9b8e4bc94bcb08a885948',
  require    => [
  ],
}

file { '/usr/local/bin/sfmc-fetcher':
  ensure  => link,
  target  => "${virtualenv_path}/data-integrations/bin/brickftp_poc.py",
  require => [
    Python::Pip['data-integrations'],
  ],
}

file { '/opt/ltv/salesforce_sfmc':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/salesforce_sfmc':
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

file { '/opt/ltv/salesforce_sfmc/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce_sfmc'],
  ],
  source  => 'puppet:///nubis/files/salesforce_sfmc/fetch.sh',
}

file { '/opt/ltv/salesforce_sfmc/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce_sfmc'],
  ],
  source  => 'puppet:///nubis/files/salesforce_sfmc/load.sh',
}

file { '/opt/ltv/salesforce_sfmc/populate_sfmc_send_jobs_unique_table.py':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce_sfmc'],
  ],
  source  => 'puppet:///nubis/files/salesforce_sfmc/populate_sfmc_send_jobs_unique_table.py',
}

file { '/opt/ltv/salesforce_sfmc/load.yml':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce_sfmc'],
  ],
  source  => 'puppet:///nubis/files/salesforce_sfmc/load.yml',
}

file { '/opt/ltv/salesforce_sfmc/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce_sfmc'],
  ],
  source  => 'puppet:///nubis/files/salesforce_sfmc/run.sh',
}
