# holding user for all jobs

group { 'ltv':
  ensure => present,
  system => true,
  gid    => 991,
}

user { 'ltv':
  ensure     => present,
  system     => true,
  gid        => 'ltv',
  uid	     => 994,
  managehome => true,
}

file { '/var/lib/ltv':
  ensure => 'directory',
}

file { '/opt/ltv':
  ensure => directory,
}

# Cleanup and archive data files
cron::daily { "${project_name}-snapshot":
  hour    => '6',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-snapshot /usr/local/bin/nubis-ltv-snapshot save",
}
