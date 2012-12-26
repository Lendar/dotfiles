nodejs:
  pkg:
    - installed
redis:
  pkg:
    - installed
mongodb:
  pkg:
    - installed
fabric:
  pip.installed
cuisine:
  pip.installed
boto:
  pip.installed
graphicsmagick:
  pkg.installed
avocado-npm:
  cmd.run:
    - name: 'npm install --silent -g grunt coffee-script clientjade'
    - cwd: {{grains['home']}}
{{grains['home']}}/.pow/localhost.iknow:
  file.append:
    - text: '3000'
    - makedirs: true
{{grains['home']}}/.powconfig:
  file.append:
    - text: 'export POW_EXT_DOMAINS=travel'
    - makedirs: true
{{grains['home']}}/.pow/restart.txt:
  file.touch:
    - watch:
      - file: {{grains['home']}}/.powconfig
