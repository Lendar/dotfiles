base:
  '*':
    - cask
    - dotfiles
    - projects
    - plist
    - salt.logs
  primary:
    - match: nodegroup
    - apps.chrome
    - apps.chrome-canary
    - apps.sublime
    - apps.alfred
    - apps.dropbox
    - apps.iterm2
    - encfs
    - logs
    - berry
    - python
    - pip
