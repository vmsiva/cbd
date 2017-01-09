# additional rhel package
node['poc']['rhel_pckg'].each do |pckg|
  package pckg do
    action :install
  end
end
service "httpd" do
	action :start
end
package 'unzip'
package 'wget'
