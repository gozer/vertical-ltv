cron::daily { "${project_name}-salesforce":
  user    => 'ltv',
  command => "nubis-cron ${project_name}-salesforce /opt/ltv/salesforce/run",
  hour    => 9,
}

python::pyvenv { "${virtualenv_path}/salesforce-fetcher" :
  ensure  => present,
  version => '3.4',
  require => [
    File[$virtualenv_path],
  ],
}

python::pyvenv { "${virtualenv_path}/vertica-csv-loader" :
  ensure  => present,
  version => '3.4',
  require => [
    File[$virtualenv_path],
  ],
}

# Install Mozilla's salesforce-fetcher
python::pip { 'salesforce-fetcher':
  ensure     => 'present',
  virtualenv => "${virtualenv_path}/salesforce-fetcher",
  url        => 'git+https://github.com/gozer/salesforce-fetcher@dbed7c62a84414102a23bc2729e767e918f16f08',
  require    => [
  ],
}

file { '/usr/local/bin/salesforce-fetcher':
  ensure  => link,
  target  => '/usr/local/virtualenvs/salesforce-fetcher/bin/salesforce-fetcher',
  require => [
    Python::Pip['salesforce-fetcher'],
  ],
}

# Install Mozilla's vertica-csv-loader
python::pip { 'vertica-csv-loader':
  ensure     => 'present',
  virtualenv => "${virtualenv_path}/vertica-csv-loader",
  url        => 'git+https://github.com/gozer/vertica-csv-loader@565d6fca68a16cea233511fa1cd08f0acf064211',
  require    => [
  ],
}

file { '/usr/local/bin/vertica-csv-loader':
  ensure  => link,
  target  => '/usr/local/virtualenvs/vertica-csv-loader/bin/vertica-csv-loader',
  require => [
    Python::Pip['vertica-csv-loader'],
  ],
}

file { '/var/log/vertica-csv-loader':
  ensure  => directory,
  owner   => 'ltv',
  group   => 'ltv',
  mode    => '0755',

  require => [
    User['ltv'],
    Group['ltv'],
  ]
}

file { '/opt/ltv/salesforce':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/salesforce':
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

file { '/opt/ltv/salesforce/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce'],
  ],
  source  => 'puppet:///nubis/files/salesforce/fetch.sh',
}

file { '/opt/ltv/salesforce/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce'],
  ],
  source  => 'puppet:///nubis/files/salesforce/load.sh',
}

file { '/opt/ltv/salesforce/sfdc_populate_sf_summary_table.py':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce'],
  ],
  source  => 'puppet:///nubis/files/salesforce/sfdc_populate_sf_summary_table.py',
}

file { '/opt/ltv/salesforce/load.yml':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce'],
  ],
  source  => 'puppet:///nubis/files/salesforce/load.yml',
}

file { '/opt/ltv/salesforce/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/salesforce'],
  ],
  source  => 'puppet:///nubis/files/salesforce/run.sh',
}
