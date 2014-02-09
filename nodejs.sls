nodejs:
  pkg:
    - installed
npm-packages:
  cmd.run:
    - name: 'npm install --silent -g grunt-cli coffee-script bower'
    - cwd: {{grains['home']}}
