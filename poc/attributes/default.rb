 # add rhel package in array
 default['poc']['rhel_pckg'] = %w{httpd dos2unix}
 default['poc']['user'] = %w{dmp dmpAuthor dmpPublish}
 default['poc']['app_bass'] = '/tmp/app_base'
 default['poc']['dir'] = ["#{node['poc']['app_bass']}/dmp", "#{node['poc']['app_bass']}/archive/dmp", "#{node['poc'][
 'app_base']}/dam/dmp", "#{node['poc']['app_base']}/dmp/scripts"]
 default['poc']['dir_own'] = 'dmp'
 default['poc']['dir_grp'] = 'dmpgrp'
