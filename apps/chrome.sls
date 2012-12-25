salt://apps/chrome.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}
