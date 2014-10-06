brew-cask:
  pkg.installed:
    - taps: caskroom/cask

{% set packages = [
  'sketch',
  'totalterminal'
] %}
{% for package in packages %}
cask-{{package}}:
  cmd.run:
    - name: brew cask install {{package}}
    - onlyif: brew cask info {{package}} | grep 'Not installed'
    - require:
      - pkg: brew-cask
{% endfor %}
