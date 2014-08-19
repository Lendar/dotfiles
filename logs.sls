{{grains['home']}}/Library/Logs/mongodb.log:
  file.symlink:
    - target: /usr/local/var/log/mongodb/mongo.log
