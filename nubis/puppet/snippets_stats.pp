cron::daily { "${project_name}-snippets-stats":
  user    => 'ltv',
  command => "nubis-cron ${project_name}-snippets-stats /opt/ltv/snippets-stats/run",
  hour    => 8,
}

python::pyvenv { "${virtualenv_path}/snippets-stats" :
  ensure  => present,
  version => '3.4',
  require => [
    File[$virtualenv_path],
  ],
}

# Install Mozilla's snippets-stats
python::pip { 'snippets-stats':
  ensure     => 'present',
  virtualenv => "${virtualenv_path}/snippets-stats",
  url        => 'git+https://github.com/mozilla-it/snippets-stats@c48cdecba9ba18cc2f2086134fb127a929073e62',
  require    => [
  ],
}

file { '/usr/local/bin/snippets-stats':
  ensure  => link,
  target  => "${virtualenv_path}/snippets-stats/bin/snippets.py",
  require => [
    Python::Pip['snippets-stats'],
  ],
}

#file { '/usr/local/bin/get_geoip_db':
#  ensure  => link,
#  target  => "${virtualenv_path}/snippets-stats/get_geoip_db.py",
#  require => [
#    Python::Pip['snippets-stats'],
#  ],
#}

file { '/usr/local/bin/get_snippets_logs':
  ensure  => link,
  target  => "${virtualenv_path}/snippets-stats/bin/get_snippets_logs.py",
  require => [
    Python::Pip['snippets-stats'],
  ],
}

file { '/opt/ltv/snippets-stats':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/var/lib/ltv/snippets-stats':
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

file { '/opt/ltv/snippets-stats/fetch':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/snippets-stats'],
  ],
  source  => 'puppet:///nubis/files/snippets-stats/fetch.sh',
}

file { '/opt/ltv/snippets-stats/load':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/snippets-stats'],
  ],
  source  => 'puppet:///nubis/files/snippets-stats/load.sh',
}

file { '/opt/ltv/snippets-stats/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/snippets-stats'],
  ],
  source  => 'puppet:///nubis/files/snippets-stats/run.sh',
}

yumrepo { 'geoipupdate3':
  descr    => 'Copr repo for geoipupdate3',
  baseurl  => 'https://copr-be.cloud.fedoraproject.org/results/gozer/geoipupdate3/epel-7-$basearch/',
  enabled  => 1,
  gpgcheck => 1,
  gpgkey   => 'https://copr-be.cloud.fedoraproject.org/results/gozer/geoipupdate3/pubkey.gpg',
  require  => [
    Yumrepo['epel'],
  ],
}

package { 'geoipupdate3':
  ensure  => 'latest',
  require => [
    Yumrepo['geoipupdate3'],
  ]
}
