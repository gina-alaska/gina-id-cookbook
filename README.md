# GINA::ID Cookbook

Description
===========

This cookbook will configure and install the gina::id server and software.


Changes
=======

## v 1.0.0 - initial deployment

Requirements
============

ruby 2.1.3
nginx
postgresql


Attributes
==========

```ruby
# config options for the cookbook recipes
node['app']['data_bag'] = 'gina_id'
node['app']['name'] = 'gina_id'

# configs options specific to this app installation
node['gina_id']['puma_port'] = '8080'
node['gina_id']['gem']['dep_packages'] = []
```


Recipes
=======

default
-------

database
--------

web
---

Resources/Providers
===================

None

Usage
=====



Examples
--------
