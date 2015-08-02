alfred:
  cmd.script:
    - name: salt://apps/alfred.sh
    - cwd: {{grains['home']}}
