{% set packages = [
  'alfred',
  'dropbox',
  'flowdock',
  'gitup',
  'keepassx',
  'nvalt',
  'omnifocus',
  'osxfuse',
  'sketch',
  'slack',
  'telegram'
] %}
{% for package in packages %}
cask-{{package}}:
  cmd.run:
    - name: brew cask install {{package}}
    - onlyif: brew cask info {{package}} | grep 'Not installed'
{% endfor %}
