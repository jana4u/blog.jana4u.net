#!/bin/bash

# sdilena slozka se jmenuje ruby, ale lze predat jine jmeno z prikazove radky: ./install.sh jmeno_slozky
if [ -z "$1" ]
  then
    SHARED_FOLDER="ruby"
  else
    SHARED_FOLDER=$1
fi

# vytvoreni prazdne slozky pro mountovani sdilene slozky
cd ~
mkdir ${SHARED_FOLDER}

# vytvoreni skriptu pro rucni mountovani
cat > mount_ruby.sh << EOF
#!/bin/bash
sudo mount -t vboxsf ${SHARED_FOLDER} ~/${SHARED_FOLDER}
EOF
chmod +x mount_ruby.sh

# nastaveni automatickeho mountu sdilene slozky pri startu
sudo su -c "printf '${SHARED_FOLDER} ${HOME}/${SHARED_FOLDER} vboxsf rw,uid=1000,gid=1000,auto,exec 0 0\n' >> /etc/fstab"
sudo su -c "printf 'vboxsf' >> /etc/modules"
sudo su -c "printf 'vboxsf' >> /etc/initramfs-tools/modules"
sudo update-initramfs -u

# okamzite rucni namountovani (bez restartu stroje)
sudo mount ~/${SHARED_FOLDER}

# vytvoreni symlinku na konfiguraci SSH, pokud je ve sdilene slozce
if [ -e ~/${SHARED_FOLDER}/.ssh ]
  then
    ln -s ~/${SHARED_FOLDER}/.ssh/ .ssh
fi

# aktualizace balicku
sudo apt-get -qq update

# instalace gitu
sudo apt-get -qq install git

# instalace rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

# instalace ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# inicializace rbenv pri kazdem spusteni bashe
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# inicializace beziciho bashe, aby fungoval rbenv bez restartu bashe
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# kontrola funkcnosti rbenv
type rbenv

# instalace balicku potrebnych pro kompilaci ruby
sudo apt-get -qq install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# instalace nekolika ruby verzi pres rbenv
rbenv install 1.8.7-p374
rbenv install 1.9.3-p551
rbenv install 2.1.5
rbenv global 2.1.5
rbenv versions

# vypnuti generovani dokumentace pri instalaci gemu
gem sources -a http://gems.github.com/
gem sources -r http://gems.github.com/
printf 'gem: --no-rdoc --no-ri\n' >> ~/.gemrc

# instalace gemu mysql2
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq install libmysqlclient-dev mysql-server
gem install mysql2

# instalace gemu sqlite3
sudo apt-get -qq install sqlite3 libsqlite3-dev
gem install sqlite3

# instalace gemu pg
sudo apt-get -qq install libpq-dev
gem install pg

# instalace MySQL Workbench (GUI)
sudo apt-get -qq install mysql-workbench

# instalace RubyMine 6.0.3
sudo apt-get -qq install openjdk-7-jre
if [ -e ~/${SHARED_FOLDER}/RubyMine-6.0.3.tar.gz ]
  then
    echo "RubyMine 6.0.3 was already downloaded."
  else
    wget -P ~/${SHARED_FOLDER} http://download.jetbrains.com/ruby/RubyMine-6.0.3.tar.gz
fi
tar -xzf ~/${SHARED_FOLDER}/RubyMine-6.0.3.tar.gz -C ~

# zmena nastaveni systemu pro hladky provoz RubyMine
sudo su -c "printf 'fs.inotify.max_user_watches = 524288\n' >> /etc/sysctl.conf"
sudo sysctl -p

# vytvoreni symlinku na konfiguraci RubyMine, pokud je ve sdilene slozce
if [ -e ~/${SHARED_FOLDER}/.RubyMine60 ]
  then
    ln -s ~/${SHARED_FOLDER}/.RubyMine60/ .RubyMine60
fi

# instalace gemu capybara-webkit
sudo apt-get -qq install qt5-default libqt5webkit5-dev
gem install capybara-webkit

# instalace gemu rmagick
sudo apt-get -qq install imagemagick libmagickwand-dev
gem install rmagick

# instalace RabbitMQ
wget -qO - https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | sudo apt-key add -
sudo add-apt-repository "deb http://www.rabbitmq.com/debian/ testing main"
sudo apt-get -qq update
sudo apt-get -qq install rabbitmq-server

# aktivace weboveho rozhrani k RabbitMQ
sudo rabbitmq-plugins enable rabbitmq_management

# admin k RabbitMQ pro prikazovou radku
wget -P ~ http://localhost:15672/cli/rabbitmqadmin
chmod +x ~/rabbitmqadmin

# instalace Elasticsearch
wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"
sudo apt-get -qq update
sudo apt-get -qq install elasticsearch

# instalace Redis
sudo apt-get -qq install redis-server

# instalace Node.js
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get -qq install nodejs
