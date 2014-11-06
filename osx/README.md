Steps
=====

Getting started
---------------

```
osx/bootstrap.sh
```

ZSH
---

```
chsh -s /bin/zsh
```

GUI Installer
-----------------

1. Open AppStore to install XCode

2. Open XCode to install gcc

3. Run in Terminal:

```
    $ android
```


Security
--------

1. Log into Dropbox

2. Log into Chrome


Settings
--------

1. Open Keyboard. Use Fn as function keys.

2. Open Keyboard. Switch to Keyboard Shortcuts. Do "Restore Defaults" for every category.

3. Open Safari. Make Chrome default browser.

4. Open "Date & Time". Setup Clock.

5. Open "Accessibility". Switch to "Zoom". Enable "Use scroll gesture".

DNS
---

1. Run in Terminal:

```
sudo scutil --set LocalHostName "lendar-macbook"
```

2. Run in Terminal:

```
curl get.pow.cx | sh
```

3. Append to /etc/hosts: `127.0.0.1 localhost.iknow.travel`

Permissions
-----------

Run regularly:

    sudo chmod -R g+rw /Library/Caches/Homebrew
    sudo chmod -R g+rw /usr/local

Cask
----

Run once:

    sudo mkdir -p /opt/homebrew-cask/Caskroom
    sudo chown -R $USER:admin /opt
    chmod -R g+w /opt


Dock
----

Run once, then reboot:

    salt-call plist_dock.remove_dock_app 'com.apple.*'
