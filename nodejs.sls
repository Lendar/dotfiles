node:
  pkg:
    - installed
npm-packages:
  cmd.run:
    - name: 'npm install --silent -g grunt-cli coffee-script bower yo'
    - cwd: {{grains['home']}}
