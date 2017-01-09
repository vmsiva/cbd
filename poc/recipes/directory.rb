#create folder <APP_BASE>/dmp, <APP_BASE>/archive/dmp, <APP_BASE>/dam/dmp, <APP_BASE>/dmp/scripts.
#change ownership of <APP_BASE>, <APP_BASE>/dam, <APP_BASE>/archive to dmp:dmpgrp
include_recipe "poc::user"
node['poc']['dir'].each do |dir|
  directory dir do
    recursive true
    owner node['poc']['dir_own']
    group node['poc']['dir_grp']
    mode '0775'
    action :create
  end
end
