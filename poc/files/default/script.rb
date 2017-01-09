
ROOT_PARTITION = `cat dmp.properties | grep "ROOT_PARTITION" | awk -F = '{print $2}' | awk '{print $1}'`.strip
INSTANCE - `cat dmp.properties | grep "INSTANCE" | awk -F = '{print $2}' | awk '{print $1}'`.strip
Instance_name - `cat dmp.properties | grep "Instance_NAME" | awk -F = '{print $2}' | awk '{print $1}'`.strip

HOST_IP - `ifconfig | grep "inet addr" | head -1 | awk '{print $2}' | awk -F : '{print $2}'`.strip
AEM_HOSTNAME - `nslookup #{HOST_IP} | grep "name = " | awk '{print $NF}' | sed s'/.$//`.strip
ARCHIVE_PATH = "#{ROOT_PARTITION}/archive/dmp"

# variables used for testing instead of originals
# ROOT_PARTITION = '/tmp'
#INSTANCE = 'publish'
#Instance_NAME = `hostname`.strip

if File.file?('/app1/archive/dmp/.bash_profile')
put 'UPDATE BASH PARAMETERS'
cont = '# .bash_profile

#get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=/app/aem/java/jdk1.8.0_112/bin:/app/aem/openssl/bin:$PATH:$HOME/bin:/sbin

export PATH

LD_LIBRARY_PATH="/app/aem/openssl/lib:$LD_LIBRARY_PATH"

export LD_LIBRARY_PATH'

File.write('/app1/archive/dmp/.bash_profile', cont)

else
  puts('WARNING::PROFILE FILE FOR USER DMP IS NOT PRESENT')
end

if File.file?('/app1/archive/dmp/.bashrc')
  puts "updating umask"

  mask_value = "umask 027"

  File.open("/app1/archive/dmp/.bashrc", "a") {|f| f.write(mask_value) }

else
  puts('WARNING::BASHRC FILE FOR USER DMP IS NOT PRESENT')
end

if File.directory?("#{ROOT_PARTITION}/dmp")

else
  puts "WARNING::#{ROOT_PARTITION}/dmp DOES NOT EXIST"
`mkdir "#{ROOT_PARTITION}/dmp"`
`mkdir "#{ROOT_PARTITION}/dmp/scripts"`
`mkdir "#{ROOT_PARTITION}/dmp/scripts/logs"`

end

if File.directory?("#{ROOT_PARTITION}/archive/dmp")
  puts "#{ROOT_PARTITION}/archive/dmp is present"

else
  puts "WARNING::#{ROOT_PARTITION}/archive/dmp IS NOT PRESENT"
    `mkdir -p "#{ROOT_PARTITION}/archive/dmp"`
end


if INSTANCE == "publish"

    AEM_PORT = 4507
    PUBLISH_PATH="#{ROOT_PARTITION}/dmp/#{Instance_NAME}"
    Dir.chdir ARCHIVE_PATH

  puts "DOWNLOAD PUBLISH FROM"

  `wget  http://dmfctoolsdr.aig.net:7080/nexus/content/repositories/config/com/aig/dmp/deploy/1.2/deploy-1.2.zip`

if File.file?("#{ARCHIVE_PATH}/publish.zip")

  Dir.chdir "#{ROOT_PARTITION}/dmp"
  `unzip "#{ARCHIVE_PATH}/publish.zip"`
  #`mv "#(ROOT_PARTITION)/dmp/publish" "#(PUBLISH_PATH)"

if File.file?("#{ROOT_PARTITION}/dmp/publish", "#{PUBLISH_PATH}")
  Dir.chdir PUBLISH_PATH

  #`sed -i "s/AEM_HOSTNAME/$AEM_HOSTNAME/g" crx-quickstart/bin/start`
  #`sed -i "s/AEM_PORT/$AEM_PORT/g" crx-quickstart/bin/start`
  #`sed -i "s/PUBLISH_PATH/$PUBLISH_PATH/g" crx-quickstart/bin/start`

  `chmod 755 "#{PUBLISH_PATH}/"`
  `chmod 755 "#{PUBLISH_PATH}/crx-quickstart"`
  `chmod 755 "#{PUBLISH_PATH}/crx-quickstart/logs"`

  else
    puts "WARNING::ZIP FILE NOT PRESENT AT LOCATION #{ARCHIVE_PATH}"
  end
end
end
