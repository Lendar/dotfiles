cask:
  cmd.run:
    - name: brew tap caskroom/cask
    - unless: brew tap | grep 'caskroom/cask'

{% set packages = [
  'totalterminal'
] %}
{% for package in packages %}
cask-{{package}}:
  cmd.run:
    - name: brew cask install {{package}}
    - onlyif: brew cask info {{package}} | grep 'Not installed'
    - require:
      - cmd: cask
{% endfor %}
