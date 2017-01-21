# -*- mode: ruby -*-
# vi: set ft=ruby :

# ----------------------------------------------------------------
# Project Configuration for Vagrant
# ----------------------------------------------------------------

GUEST_OS_LOCALE = "en_GB.UTF-8"
POSTGRESQL_VERSION = "9.5"
VM_MEMORY = "2048"
VM_NAME = "YOUR_VM_NAME"

# ----------------------------------------------------------------

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.9.1"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Use bento as the standard Ubuntu 16.04 distro is not properly confgured for use with Vagrant
  config.vm.box = "bento/ubuntu-16.04"

  # Configure the VM Language and Locale
  ENV['LANG'] = GUEST_OS_LOCALE
  ENV['LANGUAGE'] = GUEST_OS_LOCALE
  ENV['LC_ALL'] = GUEST_OS_LOCALE
  ENV['LC_MESSAGES'] = GUEST_OS_LOCALE
  ENV['LC_MONETARY'] = GUEST_OS_LOCALE
  ENV['LC_NUMERIC'] = GUEST_OS_LOCALE
  ENV['LC_TIME'] = GUEST_OS_LOCALE

  # Configurate the virtual machine RAM usage
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", VM_MEMORY]
    vb.name = VM_NAME
  end

  # Forward the default server port
  config.vm.network :forwarded_port, guest: 8000, host: 8000

  # Use Chef Solo to provision the virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]

    # Install the following receipts from the Cheffile
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "openssl"
    chef.add_recipe "vim"
    chef.add_recipe "postgresql::config_initdb"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::client"

    # Chef configuration attributes
    chef.json = {
      postgresql: {
        # Use the PostgreSQL Global Development Group repo, which contains newer versions of PostgreSQL
        apt_pgdg_postgresql: true,
        version: POSTGRESQL_VERSION,
        # Set the password for the default postgres user
        password: {
          postgres: "postgres",
        },
        # Authorization settings
        pg_hba: [
          { type: "local", db: "all", user: "postgres", addr: "", method: "ident" },
          { type: "local", db: "all", user: "all", addr: "", method: "trust" },
          { type: "host", db: "all", user: "all", addr: "127.0.0.1/32", method: "trust" },
          { type: "host", db: "all", user: "all", addr: "::1/128", method: "trust" },
          { type: "host", db: "all", user: "postgres", addr: "127.0.0.1/32", method: "trust" },
          { type: "host", db: "all", user: "user", addr: "127.0.0.1/32", method: "md5" }
        ],
      },
    }
  end

  # Give the Vagrant user ownership of /home/vagrant
  #   This is where the Python 3 project environment will be
  config.vm.provision "shell", inline: 'sudo chown -R vagrant /home/vagrant'

  # Automatically navigate to the shared project folder on 'vagrant ssh'
  config.vm.provision "shell", inline: 'echo "cd /vagrant" > ~/.profile', privileged: false

  # Update the guest OS
  config.vm.provision "shell" do |s|
    s.path = "bash/guest_os_upgrade.sh"
  end

  # Setup Django and Python
  config.vm.provision "shell" do |s|
    s.path = "bash/django_setup.sh"
    s.privileged = false
  end

end
