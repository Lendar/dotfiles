salt://apps/iterm2.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}
