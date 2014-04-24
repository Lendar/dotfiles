salt://apps/sublime.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}

{% set packages = {
  'Projects': 'Lendar/sublime-projects',
  'Js2coffee': 'Lendar/sublime-js2coffee#fix-paths',
  'CoffeeScript': 'jashkenas/coffee-script-tmbundle'
} %}

{% for name, package_spec in packages.items() %}
{% set package = package_spec.split('#')[0] %}
{% if '#' in package_spec %}
  {% set rev = package_spec.split('#')[1] %}
{% else %}
  {% set rev = 'master' %}
{% endif %}
sublime-{{name}}:
  git.latest:
    - name: git://github.com/{{package}}.git
    - rev: {{rev}}
    - target: "\"{{grains['home']}}/Library/Application Support/Sublime Text 2/Packages/{{name}}\""
    # FIXME: workaround for salt 2014.1.3 issue
    - unless: ls '{{grains['home']}}/Library/Application Support/Sublime Text 2/Packages/{{name}}'
    - require:
      - cmd: salt://apps/sublime.sh
{% endfor %}

js2coffee:
  npm.installed
