{% set packages = [
  'flowdock',
  'gitup',
  'keepassx',
  'nvalt',
  'omnifocus',
  'osxfuse',
  'sketch'
] %}
{% for package in packages %}
cask-{{package}}:
  cmd.run:
    - name: brew cask install {{package}}
    - onlyif: brew cask info {{package}} | grep 'Not installed'
{% endfor %}
