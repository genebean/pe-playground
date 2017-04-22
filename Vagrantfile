# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "genebean/centos-7-nocm"

  config.vm.define "pe" do |pe|
    pe.vm.hostname = "pe.localdomain"
    pe.vm.network "forwarded_port", guest: 80,  host: 8080
    pe.vm.network "forwarded_port", guest: 443, host: 8443


    if Dir.glob('puppet-enterprise-*-el-7-x86_64.tar.gz').empty?
      pe.vm.provision "shell", inline: "echo 'You must place a PE tarball in this direcory' && exit 1"
    end

    pe.vm.provision "shell",
      inline: <<-EOF
        tar -xzvf /vagrant/puppet-enterprise-*-el-7-x86_64.tar.gz -C /root/
        cd /root/puppet-enterprise-*-el-7-x86_64/
        ./puppet-enterprise-installer -c /vagrant/pe.conf
      EOF
    pe.vm.provision "shell", inline: "yum -y install bc"
    pe.vm.provision "shell",
      inline: <<-EOF
        echo 'Performing puppet agent runs until it exits 0.'
        until puppet agent -t
        do
          touch /tmp/agent-ran-at-`date +'%Y-%m-%d-%H%M%S.%N'`
        done
        runcount=$(echo `ls /tmp/agent-ran-* 2> /dev/null | wc -l` + 1 | bc)
        if [ ${runcount} -eq 1 ]; then action='run'; else action='runs'; fi
        echo "FYI: It took ${runcount} ${action} to get a 0 exit code from 'puppet agent -t'."
        rm -f /tmp/agent-ran-*
        rm -rf /root/puppet-enterprise-*-el-7-x86_64/
      EOF

      pe.vm.provider "virtualbox" do |v|
        v.memory = 6144
        v.cpus = 2
      end
    end # End of "pe"
end

