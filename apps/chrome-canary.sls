salt://apps/chrome-canary.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}
