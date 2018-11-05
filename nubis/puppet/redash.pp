# Redash

file { '/opt/ltv/redash':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/opt/ltv/redash/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/redash'],
  ],
  source  => 'puppet:///nubis/files/data-collector/run.sh',
}

cron::daily { "${project_name}-redash-ut_desktop_daily_active_users":
  hour    => '10',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-redash-ut_desktop_daily_active_users /opt/ltv/redash/run 49314 ut_desktop_daily_active_users",
}

cron::daily { "${project_name}-redash-ut_desktop_daily_active_users_extended":
  hour    => '10',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-redash-ut_desktop_daily_active_users_extended /opt/ltv/redash/run 51064 ut_desktop_daily_active_users_extended",
}

cron::daily { "${project_name}-redash-redash_focus_retention":
  hour    => '11',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-redash-redash_focus_retention /opt/ltv/redash/run 14209 redash_focus_retention",
}

cron::daily { "${project_name}-redash-mobile_daily_active_users":
  hour    => '12',
  minute  => fqdn_rand(60),
  user    => 'ltv',
  command => "nubis-cron ${project_name}-redash-mobile_daily_active_users /opt/ltv/redash/run 14871 mobile_daily_active_users",
}

# redash-fx_er job retired
#cron::daily { "${project_name}-redash-fx_er":
#  hour    => '17',
#  minute  => '36',
#  user    => 'ltv',
#  command => "nubis-cron ${project_name}-redash-fx_er /opt/ltv/redash/run 1687 fx_desktop_er",
#}

# redash-fx_er_by_top_countries job retired
#cron::daily { "${project_name}-redash-fx_er_by_top_countries":
#  hour    => '17',
#  minute  => '37',
#  user    => 'ltv',
#  command => "nubis-cron ${project_name}-redash-fx_er_by_top_countries /opt/ltv/redash/run 1703 fx_desktop_er_by_top_countries",
#}
