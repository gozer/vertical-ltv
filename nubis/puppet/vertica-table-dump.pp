# Vertica Table Dump

file { '/opt/ltv/vertica-table-dump':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/vertica-table-dump':
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

file { '/opt/ltv/vertica-table-dump/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/vertica-table-dump'],
  ],
  source  => 'puppet:///nubis/files/vertica-table-dump/run.sh',
}

cron::weekly { "${project_name}-vertica-table-dump":
  hour    => '0',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-vertica-table-dump /opt/ltv/vertica-table-dump/run",
}
