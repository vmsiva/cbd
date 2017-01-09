# kernel parameters to dmp user, max user processes (-u 16534), open file (-n) 16534

node['poc']['user'].each do |usr|
user usr  do
action :create
end
end
group node['poc']['dir_grp'] do
action :create
end

max_process 'updating maximum process for user' do
 usr 'dmp'
 type 'soft'
 value '1653'
end
max_process 'updating maximum process for user' do
 usr 'dmp'
 type 'hard'
 value '1653'
end
open_files 'setting open file limit' do
 usr 'dmp'
 type 'soft'
 value '6536'
end
open_files 'setting open file limit' do
 usr 'dmp'
 type 'hard'
 value '6536'
end
