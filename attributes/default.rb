default['app']['data_bag'] = 'gina_id_production'
default['app']['name'] = 'gina_id'

default[default['app']['name']]['puma_port'] = '8080'
default[default['app']['name']]['gem']['dep_packages'] = []

override['postgresql']['enable_pgdg_yum'] = true
override['postgresql']['version'] = "9.3"
override['postgresql']['dir'] = '/var/lib/pgsql/9.3/data'
override['postgresql']['config']['data_directory'] = '/var/lib/pgsql/9.3/data'
override['postgresql']['client']['packages'] = %w{postgresql93 postgresql93-devel}
override['postgresql']['server']['packages'] = %w{postgresql93-server}
override['postgresql']['server']['service_name'] = 'postgresql-9.3'
override['postgresql']['contrib']['packages'] = %w{postgresql93-contrib}
override['postgresql']['config']['listen_addresses'] = '0.0.0.0'
