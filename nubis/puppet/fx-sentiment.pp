python::pyvenv { "${virtualenv_path}/fx-sentiment" :
  ensure  => present,
  version => '3.4',
  require => [
    File[$virtualenv_path],
  ],
}

vcsrepo { '/opt/ltv/fx-sentiment':
  ensure   => present,
  provider => 'git',
  source   => 'https://github.com/mozilla-it/fx-sentiment-analysis.git',
  require  => [
    File['/opt/ltv'],
  ],
}

# Install fx-sentiment dependencies
python::requirements { 'fx-sentiment':
  requirements => '/opt/ltv/fx-sentiment/RequiredPackages.txt',
  forceupdate  => true,
  virtualenv   => "${virtualenv_path}/fx-sentiment",
  require      => [
    Vcsrepo['/opt/ltv/fx-sentiment'],
    Python::Pyvenv["${virtualenv_path}/fx-sentiment"],
  ],
}
  -> exec { 'install NTLK data':
  command   => "${virtualenv_path}/fx-sentiment/bin/python -m nltk.downloader -d /usr/local/share/nltk_data averaged_perceptron_tagger wordnet",
  logoutput => true,
}

file { '/opt/ltv/fx-sentiment':
  ensure  => directory,
  require => [
    File['/opt/ltv'],
  ]
}

file { '/opt/ltv/fx-sentiment/run':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0755',
  require => [
    File['/opt/ltv/fx-sentiment'],
  ],
  source  => 'puppet:///nubis/files/fx-sentiment/run.sh',
}

