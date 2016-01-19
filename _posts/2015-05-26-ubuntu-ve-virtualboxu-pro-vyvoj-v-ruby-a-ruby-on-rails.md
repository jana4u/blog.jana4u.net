---
layout: post
title:  "Ubuntu ve VirtualBoxu pro vývoj v Ruby a Ruby on Rails"
date:   2015-05-26 15:53:00
---

Pokud je to možné, **doporučuji používat jazyk angličtinu** (ve VirtualBoxu i v Ubuntu),
protože jakmile se objeví nějaký problém, pak velmi pravděpodobně půjde najít řešení přes Google.
Bohužel v češtině je situace o hodně horší.

## Vytvoření virtuálního stroje s Ubuntu přes VirtualBox

### Stažení potřebného software

Stáhneme a nainstalujeme nejnovější [VirtualBox](https://www.virtualbox.org/).

Stáhneme image [Ubuntu Desktop](http://www.ubuntu.com/).
Doporučuji zvolit si aktuální Long Term Support (LTS), 64-bit verzi.
Pro slabší počítače s nedostatkem paměti bude lepší 32-bit verze.
Pokud nepotřebujete grafické rozhraní, můžete použít Ubuntu Server.
Většina návodu by měla fungovat i tam, ale nezkoušela jsem to.

### Tvorba virtuálního stroje

Spustíme VirtualBox a vytvoříme si tam nový virtuální stroj (<kbd>Ctrl</kbd>+<kbd>N</kbd>).

`Name` (název virtuálního stroje) doporučuji odvodit od verze systému (např. `Ubuntu 14.04.2`), `Type` je `Linux` a `Version` `Ubuntu (64 bit)`.

Velikost paměti nastavíme dostatečně velkou - minimálně 512MB, ale jen v zelené oblasti.
Pokud se ukáže, že množství není dostatečné, lze změnit nastavení kdykoli později.

Vytvořit virtuální pevný disk chceme, tak zvolíme `Create a virtual hard drive now`.

Typ disku necháme výchozí `VDI (VirtualBox Disk Image)`.

V nastavení přidělení diskového prostoru zvolíme `Dynamically allocated`.
(Na pevném disku bude zabírat pouze tolik místa, kolik je využíváno.)

Jméno disku je dobré ponechat stejné jako je název virtuálního stroje.
Doporučená velikost 8GB je naprosto nedostatečná.
Pro dlouhodobější používání se i 20GB ukázalo být málo.
Doporučuji tedy vytvořit disk větší, protože jeho velikost nelze později jednoduše změnit!
Já zvolila 50GB.

Nyní máme hotový základ virtuálního stroje.

### Další nastavení virtuálního stroje

Vybereme vytvořený stroj a přejdeme do nastavení (<kbd>Ctrl</kbd>+<kbd>S</kbd>).

V sekci `System`, na záložce `Motherboard` by měla být vidět nastavená velikost paměti.
Dále je zde třeba nastavit pořadí bootování `Boot Order`, aby na prvním místě bylo `CD/DVD`.

V sekci `System`, na záložce `Processor` zaškrtneme `Enable PAE/NX`.

V sekci `System`, na záložce `Acceleration` by měly být zaškrtnuty obě možnosti.

V sekci `Display`, na záložce `Video` zvýšíme `Video Memory` na 128MB a zaškrtneme `Enable 3D Acceleration`.

V sekci `Storage` by měl být vidět námi vytvořený disk.
Pod `Controller: IDE` zvolíme `Empty` a klikneme na ikonu CD vpravo.
Z rozbaleného menu zvolíme `Choose a virtual CD/DVD disk file...` a vybereme stažený image Ubuntu.

V sekci `Network` ponecháme povolený `Adapter 1` nastavený jako `NAT` a povolíme ještě `Adapter 2` jako `Host-only Adapter`.

Uložíme změny kliknutím dole na tlačítko `OK`.

### Nastavení složky sdílené do virtuálního stroje

Opět vybereme vytvořený stroj a přejdeme do nastavení (<kbd>Ctrl</kbd>+<kbd>S</kbd>).

V sekci `Shared Folders` přidáme novou složku.

`Folder Path` je cesta do složky, kterou chceme zpřístupnit.
`Folder Name` je název, pod kterým bude přístupná ve virtuálním stroji.
(V mém případě `ruby`.)

### Instalace Ubuntu do virtuálního stroje

Vybereme vytvořený stroj a spustíme ho.

Zvolíme jazyk systému a pak klikneme na tlačítko `Install Ubuntu`.

V dalším kroku je možné zaškrtnutím `Download updates while installing`
rovnou nechat stáhnout aktualizace již během instalace.
Není to nezbytné, protože to lze udělat i později.
Také je možné odsouhlasit instalaci software třetích stran `Install this third-party software`,
ale pro vývojářský stroj nic z toho není potřeba.
Pokračujeme kliknutím na tlačítko `Continue`.

V dalším kroku postačí nechat vybranou volbu `Erase disk and install Ubuntu`.
Pokračujeme kliknutím na tlačítko `Install Now`.

Potvrdíme zápis změn na disk kliknutím na tlačítko `Continue`.

Časové pásmo nastavíme `Prague` a pokračujeme kliknutím na tlačítko `Continue`.

Rozložení klávesnice zvolíme `Czech` a pro klasickou QWERTZ klávesnici pak znovu `Czech`.
Pokračujeme kliknutím na tlačítko `Continue`.

V dalším kroku je potřeba zadat své jméno a příjmení `Your name`.
Je také nutné pojmenovat počítač `Your computer's name`,
zvolit si přihlašovací jméno `Pick a username`
a nastavit heslo `Choose password` a `Confirm your password`.
Jméno a heslo může být klidně triviální, protože jde jen o virtuální stroj.
Pro virtuální stroj se pak také hodí zvolit `Log in automatically`,
aby se člověk nemusel pokaždé přihlašovat zadáváním hesla.
Pokračujeme kliknutím na tlačítko `Continue`.

Instalaci dokončíme kliknutím na tlačítko `Restart Now`.

### Instalace Guest Additions z VirtualBoxu do Ubuntu

Po spuštění stroje je třeba doinstalovat Guest Additions z VirtualBoxu.

Guest Additions z VirtualBoxu umožňují fungovat v nějakém rozumnějším rozlišení, sdílet složky, schránku atp.

V menu okna VirtualBoxu zvolíme `Devices` &rarr; `Insert Guest Additions CD image...`.
V okně, které se pak v Ubuntu objeví, zvolíme `Run` a po zadání hesla začne instalace.
Až se objeví `Press Return to close this window...` je instalace dokončena.
Okno zavřeme stisknutím klávesy <kbd>Enter</kbd>.

Po instalaci je třeba stroj restartovat. Rozdíl by se měl projevit hned po příštím spuštění.

### Zapnutí sdílené schránky mezi systémy

V menu okna VirtualBoxu se spuštěným Ubuntu zvolíme `Devices` &rarr; `Shared Clipboard` a nastavíme `Bidirectional`.

### Doporučené nastavení Ubuntu ve VirtualBoxu

#### Úpravy Launcheru

Pro lepší práci se hodí upravit si Launcher.

Zbytečné ikony odstraníme kliknutím pravým tlačítkem a zvolíme `Unlock from Launcher`.

Pokud si naopak chceme přidat nějaké užitečné věci, pak klikneme na první ikonu Launcheru
(nebo zmáčkneme klávesu <kbd>Win</kbd>) a začneme psát název aplikace.
Až se nám objeví požadovaná aplikace, tak ji spustíme a na její ikoně na Launcheru přes pravé tlačítko zvolíme `Lock to Launcher`.
Aplikace, které by se mohly hodit jsou např. `Terminal`, `Text Editor` nebo `System Monitor`.

Pořadí ikon se mění podržením ikony a následným přetažením na jiné místo.

#### Vypnutí uzamykání stroje

Pro virtuální stroj je také vhodné vypnout uzamykání.

Klikneme na ikonu v pravém horním rohu Ubuntu, v menu zvolíme `System Settings`.
V okně s nastaveními zvolíme `Brightness & Lock`.
Přenastavíme `Lock` na `OFF` a zrušíme zaškrtnutí `Require my password when waking from suspend`.

## Uložení snapshotu systému po instalaci a základním nastavení

Až si vše základní nastavíme ke své spokojenosti, vypneme Ubuntu.
(Pro řádné ukončení klikneme na ikonu v pravém horním rohu Ubuntu, v menu zvolíme `Shut Down...` a v okně pak opět `Shut Down`.)

V přehledu virtuálních strojů by teď pod tím naším mělo být napsáno `Powered Off`.

Vybereme náš stroj a vpravo nahoře zvolíme `Snapshots`.

Klikneme pravým tlačítkem na `Current State` a zvolíme `Take Snapshot` (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd>).
Každý snapshot je třeba pojmenovat - vyplnit `Snapshot Name`.
Je možné nechat předvyplněné jméno nebo si nastavit libovolné vlastní.
Můžete pro pojmenování použít třeba aktuální datum.

## Instalace software potřebného pro vývoj

### Použití kompletního instalačního skriptu

Je možné si přímo přes `Terminal` stáhnout [instalační skript](/assets/install.sh):

{% highlight sh %}
wget -P ~ {{ site.url }}/assets/install.sh
{% endhighlight %}

Alternativně je možné si [instalační skript](/assets/install.sh) stáhnout,
jeho obsah zkopírovat přes schránku do programu `Text Editor` v Ubuntu
a uložit do domovské složky - např. jako `install.sh`.
(Pro využití tohoto řešení je třeba mít zapnuté sdílení schránky mezi systémy.)

Skript pak spustíme zadáním:

{% highlight sh %}
cd ~
chmod +x install.sh
./install.sh
{% endhighlight %}

Během instalace bude ještě třeba zadat heslo.

### Postupné zadávání potřebných příkazů

Je dobré mít zapnuté sdílení schránky mezi systémy, pokud chcete příkazy kopírovat a vkládat.
Je samozřejmě možné jednotlivé příkazy psát i ručně.
Po zadávání příkazů použijeme program `Terminal`.

#### Sdílená složka z hosta do virtuálního Ubuntu

Ve virtuálním stoji je třeba si vytvořit prázdnou složku - nejlépe asi v domovském adresáři uživatele.
(Moje složka se jmenuje `ruby`.)

{% highlight sh %}
cd ~
mkdir ruby
{% endhighlight %}

##### Jednorázové připojení sdílené složky

Pro jednorázové připojení si lze vytvořit shellový skript:

{% highlight sh %}
cat > mount_ruby.sh << EOF
#!/bin/bash
sudo mount -t vboxsf ruby ~/ruby
EOF
chmod +x mount_ruby.sh
{% endhighlight %}

A pak jej spustit:

{% highlight sh %}
./mount_ruby.sh
{% endhighlight %}

##### Trvalé připojení sdílené složky (po každém startu virtuálního stroje)

Je třeba upravit nastavení systému:

{% highlight sh %}
sudo su -c "printf 'ruby ${HOME}/ruby vboxsf rw,uid=1000,gid=1000,auto,exec 0 0\n' >> /etc/fstab"
sudo su -c "printf 'vboxsf' >> /etc/modules"
sudo su -c "printf 'vboxsf' >> /etc/initramfs-tools/modules"
sudo update-initramfs -u
{% endhighlight %}

Také je možné otevřít si soubor /etc/fstab pro ruční úpravy v editoru:

{% highlight sh %}
sudo gedit /etc/fstab
{% endhighlight %}

Aby se projevily změny bez restartu stroje je třeba ještě spustit:

{% highlight sh %}
sudo mount ~/ruby
{% endhighlight %}

nebo

{% highlight sh %}
sudo mount -a
{% endhighlight %}

#### Aktualizace seznamu balíčků

Doporučuji provést před jakoukoli další instalací balíčků.

{% highlight sh %}
sudo apt-get -qq update
{% endhighlight %}

#### Instalace [Git](https://git-scm.com/)u

{% highlight sh %}
sudo apt-get -qq install git
{% endhighlight %}

#### Instalace [rbenv](https://github.com/sstephenson/rbenv)

{% highlight sh %}
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
{% endhighlight %}

Nakonfigurování bashe, aby byl příkaz rbenv přístupný:

{% highlight sh %}
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
{% endhighlight %}

Po restartu programu `Terminal` zadáme:

{% highlight sh %}
type rbenv
{% endhighlight %}

Výstup by měl začínat: `rbenv is a function`

#### Instalace [ruby-build](https://github.com/sstephenson/ruby-build) jako pluginu pro rbenv

{% highlight sh %}
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
{% endhighlight %}

#### Instalace balíčků potřebných pro kompilaci ruby

Zdroj: [ruby-build wiki](https://github.com/sstephenson/ruby-build/wiki)

{% highlight sh %}
sudo apt-get -qq install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
{% endhighlight %}

#### Instalace jednotlivých verzí [Ruby](https://www.ruby-lang.org/) přes rbenv

Vypsání dostupných verzí ruby:

{% highlight sh %}
rbenv install -l
{% endhighlight %}

Instalace poslední oficiální verze ruby 1.8.7:

{% highlight sh %}
rbenv install 1.8.7-p374
{% endhighlight %}

Instalace aktuálně poslední verze ruby 1.9.3:

{% highlight sh %}
rbenv install 1.9.3-p551
{% endhighlight %}

Instalace aktuálně poslední verze ruby 2.1:

{% highlight sh %}
rbenv install 2.1.5
{% endhighlight %}

Nastavení výchozího ruby (nejlépe to nejnovější):

{% highlight sh %}
rbenv global 2.1.5
{% endhighlight %}

Kontrola ruby verzí (u výchozí verze by měla být hvězdička):

{% highlight sh %}
rbenv versions
{% endhighlight %}

#### Vypnutí generování dokumentace pro gemy pro rychlejší instalaci

Ve zkratce jde o vygenerování .gemrc a jeho následná úprava:

{% highlight sh %}
gem sources -a http://gems.github.com/
gem sources -r http://gems.github.com/
printf 'gem: --no-rdoc --no-ri\n' >> ~/.gemrc
{% endhighlight %}

#### Instalace [MySQL](https://www.mysql.com/)

Zdroj: [Stack Overflow](http://stackoverflow.com/questions/3608287/error-installing-mysql2-failed-to-build-gem-native-extension)

Instalace balíčků (vč. serveru) a mysql2 gemu:

{% highlight sh %}
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq install libmysqlclient-dev mysql-server
gem install mysql2
{% endhighlight %}

#### Instalace [SQLite](https://www.sqlite.org/)

Instalace balíčků a sqlite3 gemu:

{% highlight sh %}
sudo apt-get -qq install sqlite3 libsqlite3-dev
gem install sqlite3
{% endhighlight %}

#### Instalace [PostgreSQL](http://www.postgresql.org/)

Zdroj: [Installing PostgreSQL on Ubuntu for Rails - gem install pg](http://i.justrealized.com/2010/install-pg-gem-postgresql-ubuntu/)

{% highlight sh %}
sudo apt-get -qq install libpq-dev
gem install pg
{% endhighlight %}

#### Instalace [MySQL Workbench](http://www.mysql.com/products/workbench/)

MySQL Workbench je GUI pro práci s MySQL databází.

{% highlight sh %}
sudo apt-get -qq install mysql-workbench
{% endhighlight %}

#### Instalace [RubyMine](https://www.jetbrains.com/ruby/)

RubyMine je IDE pro vývoj v Ruby a Ruby on Rails.

Já mám aktuálně licenci pro verzi 8.0.3, pokud tedy chcete používat jinou, je třeba číslo verze změnit.

Stáhnout si Linuxovou verzi lze pomocí příkazu:

{% highlight sh %}
wget -P ~/ruby https://download.jetbrains.com/ruby/RubyMine-8.0.3.tar.gz
{% endhighlight %}

Následující skript očekává již stažený .tar.gz RubyMine ve složce `~/ruby`:

{% highlight sh %}
sudo apt-get -qq install openjdk-7-jre
tar -xzf ~/ruby/RubyMine-8.0.3.tar.gz -C ~
{% endhighlight %}

Upravíme ještě konfiguraci systému, aby RubyMine fungovalo dobře:

{% highlight sh %}
sudo su -c "printf 'fs.inotify.max_user_watches = 524288\n' >> /etc/sysctl.conf"
sudo sysctl -p
{% endhighlight %}

RubyMine spustíme např. takto:

{% highlight sh %}
cd ~/RubyMine-8.0.3/bin
./rubymine.sh
{% endhighlight %}

#### Instalace gemu [capybara-webkit](https://github.com/thoughtbot/capybara-webkit)

Zdroj: [capybara-webkit wiki](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

{% highlight sh %}
sudo apt-get -qq install qt5-default libqt5webkit5-dev
gem install capybara-webkit
{% endhighlight %}

#### Instalace gemu [rmagick](http://www.imagemagick.org/RMagick/doc/)

Zdroj: [Stack Overflow](http://stackoverflow.com/questions/3704919/installing-rmagick-on-ubuntu)

{% highlight sh %}
sudo apt-get -qq install imagemagick libmagickwand-dev
gem install rmagick
{% endhighlight %}

#### Instalace [RabbitMQ](https://www.rabbitmq.com/)

Zdroj: [RabbitMQ - Installing on Debian / Ubuntu](https://www.rabbitmq.com/install-debian.html)

{% highlight sh %}
wget -qO - https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | sudo apt-key add -
sudo add-apt-repository "deb http://www.rabbitmq.com/debian/ testing main"
sudo apt-get -qq update
sudo apt-get -qq install rabbitmq-server
{% endhighlight %}

Zapnutí RabbitMQ webového rozhraní na URL [http://localhost:15672/](http://localhost:15672/)

Zdroj: [RabbitMQ - Management Plugin](https://www.rabbitmq.com/management.html)

{% highlight sh %}
sudo rabbitmq-plugins enable rabbitmq_management
{% endhighlight %}

Vytvoření administrativního příkazu pro správu RabbitMQ z příkazové řádky

Zdroj: [RabbitMQ - Management Command Line Tool](https://www.rabbitmq.com/management-cli.html)

{% highlight sh %}
wget -P ~ http://localhost:15672/cli/rabbitmqadmin
chmod +x ~/rabbitmqadmin
{% endhighlight %}

#### Instalace [elasticsearch](http://www.elasticsearch.org/)

{% highlight sh %}
wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"
sudo apt-get -qq update
sudo apt-get -qq install elasticsearch
{% endhighlight %}

#### Instalace [Redis](http://redis.io/)

{% highlight sh %}
sudo apt-get -qq install redis-server
{% endhighlight %}

#### Instalace [Node.js](https://nodejs.org/)

Zdroj: [Installing Node.js via package manager](https://nodejs.org/en/download/package-manager/)

{% highlight sh %}
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get -qq install nodejs
{% endhighlight %}

### Přidání SSH klíčů

Stačí zkopírovat soubory `id_rsa.pub` a `id_rsa` přes sdílenou složku do složky `~/.ssh` v Ubuntu, pokud je chcete mít přímo ve virtuálním stroji.

Druhou možností je dát si je do složky ve sdílené složce a vytvořit si na ni symbolický odkaz:

{% highlight sh %}
cd ~
ln -s ~/ruby/.ssh/ .ssh
{% endhighlight %}

## Provoz a údržba Ubuntu

#### Aktualizace nainstalovaných balíčků

{% highlight sh %}
sudo apt-get update
sudo apt-get upgrade
{% endhighlight %}

#### Problémy po aktualizaci kernelu

Pokud se aktualizuje kernel, je většinou třeba pak znovu nainstalovat Guest Additions z VirtualBoxu a následně spustit:

{% highlight sh %}
sudo update-initramfs -u
{% endhighlight %}

Bez toho nefunguje automatické připojení sdílených složek při startu, normální rozlišení ani sdílená schránka.

## Použité verze software

V době sepsání byly aktuální tyto verze:

* VirtualBox 4.3.28-100309
* Ubuntu 14.04.2 LTS 64-bit

## Poděkování

Děkuji kolegům z [KRAXNET](http://www.kraxnet.cz/)u, kteří mi pomohli skripty vylepšit a doladit.

## Aktualizace

* 5.6.2015
  * přidána instalace Redisu
  * využití HOME pro získání cesty do domovské složky
  * konfigurovatelné jméno sdílené složky v install.sh skriptu
  * přidáno poděkování

* 27.7.2015
  * přidána tvorba symbolických odkazů na .ssh a .RubyMine60

* 19.1.2016
  * přidána instalace Node.js
  * aktualizace na RubyMine 8.0.3
