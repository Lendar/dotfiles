{{grains['home']}}/.profile:
  file.managed:
    - source: salt://dotfiles/profile.sh
{{grains['home']}}/.iterm2_helpers.sh:
  file.managed:
    - source: salt://dotfiles/iterm2_helpers.sh
{{grains['home']}}/.gemrc:
  file.managed:
    - source: salt://dotfiles/gemrc
{{grains['home']}}/.gitconfig:
  file.managed:
    - source: salt://dotfiles/gitconfig
    - template: jinja
{{grains['home']}}/.ssh/config:
  file.symlink:
    - target: {{grains['home']}}/Dropbox/.home/.ssh/config
    - makedirs: true
{{grains['home']}}/.ssh/id_rsa:
  file.copy:
    - source: {{grains['home']}}/Dropbox/.home/.ssh/id_rsa
    - force: true
    - makedirs: true
    - mode: 600
{{grains['home']}}/.ssh/id_rsa.pub:
  file.copy:
    - source: {{grains['home']}}/Dropbox/.home/.ssh/id_rsa.pub
    - force: true
    - makedirs: true
{{grains['home']}}/env:
  file.symlink:
    - target: {{grains['home']}}/Dropbox/.home/env
dotfiles-keyboard-layouts:
  file.recurse:
    - name: "{{grains['home']}}/Library/Keyboard Layouts"
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
    - template: jinja
    - require:
      - file: dotfiles-keyboard-layouts

