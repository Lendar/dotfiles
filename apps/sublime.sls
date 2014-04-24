salt://apps/sublime.sh:
  cmd:
    - script
    - cwd: {{grains['home']}}

{% set packages = [
  'Lendar/sublime-projects',
  'Lendar/sublime-js2coffee#fix-paths',
  'jashkenas/coffee-script-tmbundle'
] %}

{% for package_spec in packages %}
{% set package = package_spec.split('#')[0] %}
{% if '#' in package_spec %}
  {% set rev = package_spec.split('#')[1] %}
{% else %}
  {% set rev = 'master' %}
{% endif %}
{% set name = package.split('/')[1] %}
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
