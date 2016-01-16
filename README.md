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

TODO: remake script with masterless in mind

```
~/.salt/srv/salt/osx/install-salt.py <name>
```

goal: ~/.salt/minion

### Step 3: run

salt-call -c ~/.salt state.highstate

TODO: fix brew
TODO: fix .gitconfig name error (missing pillar)


### Step: change shell

TODO: include in bootstrap script

chsh -s /bin/zsh

---

TODO: setup iterm

defaults write
PrefsCustomFolder = "/Users/lendar/Dropbox/.home/iterm";

