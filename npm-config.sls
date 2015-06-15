{% set options = {
  'init-author-email': salt['pillar.get']('email'),
  'init-author-name': salt['pillar.get']('fullname'),
  'init-license': 'MIT'
} %}

{% for key, value in options.items() %}
{% if value %}
npm-config-{{key}}:
  cmd.run:
    - name: npm set {{key}} {{value | json}}
    - unless: test $(npm get {{key}}) = {{value | json}}
{% endif %}
{% endfor %}
