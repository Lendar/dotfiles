encfs:
  pkg:
    - installed
{{grains['home']}}/.profile:
  file.managed:
    - source: salt://dotfiles/profile.sh
{{grains['home']}}/.gemrc:
  file.managed:
    - source: salt://dotfiles/gemrc
{{grains['home']}}/.ssh/config:
  file.symlink:
    - target: {{grains['home']}}/Dropbox/.home/.ssh/config
    - makedirs: true
{{grains['home']}}/.ssh/id_rsa:
  file.symlink:
    - target: {{grains['home']}}/Dropbox/.home/.ssh/id_rsa
    - makedirs: true
    - mode: 600
{{grains['home']}}/.ssh/id_rsa.pub:
  file.symlink:
    - target: {{grains['home']}}/Dropbox/.home/.ssh/id_rsa.pub
    - makedirs: true
{{grains['home']}}/bin/subl:
  file.symlink:
    - target: /Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl
    - makedirs: true
"{{grains['home']}}/Library/Keyboard Layouts":
  file.recurse:
    - source: "salt://dotfiles/Keyboard Layouts"
zsh:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: {{grains['home']}}/.oh-my-zsh
  file.managed:
    - name: {{grains['home']}}/.zshrc
    - source: salt://dotfiles/zshrc.zsh
sublime-config:
  file.symlink:
    - name: {{grains['home']}}/Library/Application Support/Sublime Text 2/Packages/User
    - target: {{grains['home']}}/Dropbox/Library/Application Support/Sublime Text 2/Packages/User
    - makedirs: true
osx-defaults-script:
  cmd.script:
    - source: salt://osx/defaults.sh

