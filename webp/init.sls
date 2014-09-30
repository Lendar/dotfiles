webp-brew-formula:
  file.managed:
    - name: /usr/local/Library/Formula/webp.rb
    - source: salt://webp/webp.rb

webp:
  pkg.installed:
    - version: 0.4.1_1
    - require:
      - file: webp-brew-formula
