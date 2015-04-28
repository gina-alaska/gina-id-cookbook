name             'gina_id'
maintainer       'GINA'
maintainer_email 'will@alaska.edu'
license          'mit'
description      'Installs/Configures gina_id'
long_description 'Installs/Configures gina_id'
version          '1.2.1'

depends 'chef-vault'
depends 'postgresql'
depends 'database'
depends 'rubies', '~> 0.1.0'
depends 'runit'
depends 'git'
depends 'user'
depends 'nodejs', '~> 2.4.0'
depends 'nginx'
depends 'certificate', '~> 1.0.0'
depends 'backup', '~> 1.3.0'
