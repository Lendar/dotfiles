cask-tap-versions:
  pkg.installed:
    - pkgs: []
    - taps: caskroom/versions

sublime-app:
  cmd.run:
    - name: brew cask install sublime-text3
    - onlyif: brew cask info sublime-text3 | grep 'Not installed'
    - require:
      - pkg: cask-tap-versions

{% set packages = {
  'Package Control': 'wbond/package_control',
  'PlainTasks': 'aziz/PlainTasks',
  'Projects': 'Lendar/sublime-projects',
  'Theme - Soda': 'buymeasoda/soda-theme',
  'Js2coffee': 'Lendar/sublime-js2coffee#fix-paths',
  'Jade': 'Intervox/jade-tmbundle#cat-syntax',
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
    - target: {{grains['home']}}/Library/Application Support/Sublime Text 3/Packages/{{name}}
    - unless: ls '{{grains['home']}}/Library/Application Support/Sublime Text 3/Packages/{{name}}'
    - require:
      - cmd: sublime-app
{% endfor %}

js2coffee:
  npm.installed:
    - require:
      - pkg: node
