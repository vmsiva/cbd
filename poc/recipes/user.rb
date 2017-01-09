# kernel parameters to dmp user, max user processes (-u 16534), open file (-n) 16534

node['poc']['user'].each do |usr|
user usr  do
action :create
end
end
group node['poc']['dir_grp'] do
action :create
end

execute 'setting processes and file open limit' do
command <<-EOH
echo "dmp soft nproc 16534" >> /etc/security/limits.conf
echo "dmp hard nproc 16534" >> /etc/security/limits.conf
echo "dmp soft nofile 65536" >> /etc/security/limits.conf
echo "dmp hard nofile 65536" >> /etc/security/limits.conf
EOH
end
