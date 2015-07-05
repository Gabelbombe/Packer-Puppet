## Golden Image creation

#### Required:

There is some required software needed to run the following:
Brew install the following
```
$ brew cask install virtualbox vagrant vagrant-manager
$ brew tap homebrew/binary
$ brew install packer
```

 * [VMWare Fusion](http://www.vmware.com/go/try-fusionpro-en)
 * [Parallels Desktop](http://buy.parallels.com/329/pl/67432930-eXRF2V6vmrxj02kCvVzZ-1-1-1)
 * [Parallels Virtualization SDK](http://www.parallels.com/download/pvsdk/)


`Note: Fusion installer via Mac is more stable than using the Fusion download above, ask me how...`


##### Notice

After having __several major issues__ with installing VMWare Fusion on OSX I recommend using this
as the _preferred_ installation method from here out.

```shell
  ## Install Brew
  $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  ## Install Cask for Brew
  $ brew install caskroom/cask/brew-cask

  ## Install Fusion
  $ brew cask install --appdir='/Applications' vmware-fusion

  ## Validate Fusion App
  $ open "/Applications/VMware Fusion.app"

```


##### Notice

In order to vagrant up the oracle-6.6 packer file you WILL be prompted for your users (laptop/desktop) password.
If you don't want to type your password on every vagrant up, Vagrant uses thoughtfully crafted commands to make
fine-grained sudoers modifications possible to avoid entering your password. Below, we have a couple example
sudoers entries. Note that you may have to modify them slightly on certain hosts because the way Vagrant modifies
/etc/exports changes a bit from OS to OS.

For OS X, sudoers should have this entry

```script
  Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
  Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
  Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports
  %admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE
```

For Ubuntu Linux , sudoers should look roughly like this

```script
  Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
  Cmnd_Alias VAGRANT_NFSD_CHECK = /etc/init.d/nfs-kernel-server status
  Cmnd_Alias VAGRANT_NFSD_START = /etc/init.d/nfs-kernel-server start
  Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
  Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /bin/sed -r -e * d -ibak /etc/exports
  %sudo ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY, VAGRANT_EXPORTS_REMOVE
```

For Fedora/RHEL Linux, sudoers should look roughly like this (given your user belongs to the vagrant group)

```script
  Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
  Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status nfs-server.service
  Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
  Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
  Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /bin/sed -r -e * d -ibak /etc/exports
  %vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY, VAGRANT_EXPORTS_REMOVE
```

For Windows users

 * This is not for you, consider building your own or moving to another OS

#### Misc Errors

.....

#### Todo:

 * CRONtab to read/wipe `output_directory` prior to packer build
