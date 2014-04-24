salt://apps/sublime.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}

{% set packages = [
  'Lendar/sublime-projects',
  'jashkenas/coffee-script-tmbundle'
] %}

{% for package in packages %}
{% set name = package.split('/')[1] %}
sublime-{{name}}:
  git.latest:
    - name: git://github.com/{{package}}.git
    - target: "\"{{grains['home']}}/Library/Application Support/Sublime Text 2/Packages/{{name}}\""
    # FIXME: workaround for salt 2014.1.3 issue
    - unless: ls '{{grains['home']}}/Library/Application Support/Sublime Text 2/Packages/{{name}}'
    - require:
      - cmd: salt://apps/sublime.sh
{% endfor %}
