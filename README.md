## Howto


### Step 1: clone

```bash
git clone https://github.com/Lendar/dotfiles.git ~/.salt/srv/salt
```


### Step 2: bootstrap saltstack (optional)

```bash
osx/bootstrap.sh
```


### Step 2: config

```
~/.salt/srv/salt/osx/install-salt.py <name> your.salt.server
```


### Step 3: run locally or remotely

Locally

```
salt-call -c ~/.salt state.highstate
```

Remotely

```
salt '*' state.highstate
```


### TODO

setup iterm:

```
defaults write
PrefsCustomFolder = "/Users/lendar/Dropbox/.home/iterm";
``` 
