encfs:
  pkg:
    - installed
{{grains['home']}}/.profile:
  file.managed:
    - source: salt://dotfiles/profile.sh
{{grains['home']}}/.ssh/config:
  file.symlink:
    - target: {{grains['home']}}/Dropbox/.home/.ssh/config
    - makedirs: true
{{grains['home']}}/.ssh/id_rsa:
  file.symlink:
    - target: {{grains['home']}}/Dropbox/.home/.ssh/id_rsa
    - makedirs: true
{{grains['home']}}/.ssh/id_rsa:
  file.managed:
    - mode: 600
{{grains['home']}}/bin/subl:
  file.symlink:
    - target: /Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl
    - makedirs: true
"{{grains['home']}}/Library/Keyboard Layouts":
  file.recurse:
    - source: "salt://dotfiles/Keyboard Layouts"
