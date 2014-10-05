alfred:
  cmd.script:
    - name: salt://apps/alfred.sh
    - cwd: {{grains['home']}}

alfred-search-cask-apps:
  alfred.defaultresults_scope_add:
    - name: /opt/homebrew-cask/Caskroom
    - require:
      - cmd: alfred
