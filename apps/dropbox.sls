salt://apps/dropbox.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}
