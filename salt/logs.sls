{% for item in ['minion', 'master'] %}
{{grains['home']}}/Library/Logs/salt/{{item}}:
  file.symlink:
    - target: {{grains['home']}}/.salt/var/log/salt/{{item}}
    - makedirs: true
{% endfor %}
