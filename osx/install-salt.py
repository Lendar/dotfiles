#!/usr/bin/env python
import sys
import os
import subprocess
import time


HOME = os.path.expanduser('~')
USER = os.getlogin()

BANNER = 'Auto-generated by install-salt {ver} on {date}'.format(
    ver='v4', date=time.strftime('%Y-%m-%d'))


def write_minion_launchctl():
    agentsdir = HOME + '/Library/LaunchAgents'
    if not os.path.exists(agentsdir):
        os.makedirs(agentsdir)
    with open(HOME + '/Library/LaunchAgents/org.saltstack.salt-minion.plist', 'w') as f:
        f.write('''<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<!-- {banner} -->
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>org.saltstack.salt-minion</string>

    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/salt-minion</string>
        <string>-c</string>
        <string>/Users/{user}/.salt</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/Users/{user}/node_modules/.bin:/usr/local/share/npm/bin:/Users/{user}/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin</string>
    </dict>
</dict>
</plist>
'''.format(user=USER, banner=BANNER))


def write_minion_cfg(id):
    try: os.makedirs(HOME + '/.salt')
    except: pass
    with open(HOME + '/.salt/minion', 'w') as f:
        f.write('''# {banner}
id: {id}-{user}
user: {user}
master: 'lendar-macbook.local'
root_dir: /Users/{user}/.salt
pidfile: /Users/{user}/.salt/var/run/salt-minion.pid
file_roots:
  base:
    - /Users/{user}/.salt/srv/base'''.format(
        id=id,
        banner=BANNER,
        user=USER))


def start_salt():
    cmd = 'launchctl unload -w /Users/{user}/Library/LaunchAgents/org.saltstack.salt-minion.plist'.format(user=USER)
    subprocess.call(cmd.split(' '))
    cmd = 'launchctl load -w /Users/{user}/Library/LaunchAgents/org.saltstack.salt-minion.plist'.format(user=USER)
    subprocess.call(cmd.split(' '))


def main():
    if len(sys.argv) < 2:
        print 'Usage: {0} <machine id>\n'.format(sys.argv[0])
        return
    else:
        id = sys.argv[1]
    print 'Installing salt for machine {0}'.format(id)
    write_minion_launchctl()
    write_minion_cfg(id)
    start_salt()


if __name__ == '__main__':
    main()
