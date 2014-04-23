salt://apps/sublime.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}

sublime-packages:
  git.latest:
    - name: git://github.com/Lendar/sublime-projects.git
    - target: "\"{{grains['home']}}/Library/Application Support/Sublime Text 2/Packages/sublime-projects\""
    # FIXME: workaround for salt 2014.1.3 issue
    - unless: ls '{{grains['home']}}/Library/Application Support/Sublime Text 2/Packages/sublime-projects'
    - require:
      - cmd: salt://apps/sublime.sh
