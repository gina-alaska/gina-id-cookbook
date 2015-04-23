default['app']['data_bag'] = 'gina_id_production'
default['app']['name'] = 'gina_id'
default['app']['ssl_data_bag'] = 'id.gina.alaska.edu'

default[default['app']['name']]['puma_port'] = '8080'
default[default['app']['name']]['gem']['dep_packages'] = []

override["iptables-ng"]["rules"]["filter"]["INPUT"]["21-ssh"]["rule"] = "-m state --state NEW -p tcp --dport 22 -m recent --update --seconds 60 --hitcount 20 -j DROP"
override["iptables-ng"]["rules"]["filter"]["INPUT"]["21-ssh"]["ip_version"] = 4
override["iptables-ng"]["rules"]["filter"]["INPUT"]["80-http"]["rule"] = "-m state --state NEW -p tcp --dport 80 -j ACCEPT"
override["iptables-ng"]["rules"]["filter"]["INPUT"]["80-http"]["ip_version"] = 4
override["iptables-ng"]["rules"]["filter"]["INPUT"]["443-https"]["rule"] = "-m state --state NEW -p tcp --dport 443 -j ACCEPT"
override["iptables-ng"]["rules"]["filter"]["INPUT"]["443-https"]["ip_version"] = 4

override['postgresql']['enable_pgdg_yum'] = true
override['postgresql']['version'] = "9.3"
override['postgresql']['dir'] = '/var/lib/pgsql/9.3/data'
override['postgresql']['config']['data_directory'] = '/var/lib/pgsql/9.3/data'
override['postgresql']['client']['packages'] = %w{postgresql93 postgresql93-devel}
override['postgresql']['server']['packages'] = %w{postgresql93-server}
override['postgresql']['server']['service_name'] = 'postgresql-9.3'
override['postgresql']['contrib']['packages'] = %w{postgresql93-contrib}
override['postgresql']['config']['listen_addresses'] = '0.0.0.0'
