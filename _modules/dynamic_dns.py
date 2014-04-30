# -*- coding: utf-8 -*-
'''
Update master ip due to DNS change.

Problem is described here: https://groups.google.com/d/msg/salt-users/eoEFWPoRCzg/v-UPbZl64OEJ
'''

import logging
log = logging.getLogger(__name__)

def _restart():
    return __salt__['cmd.run'](
        'launchctl unload -w ~/Library/LaunchAgents/org.saltstack.salt-minion.plist;'
        'launchctl load -w ~/Library/LaunchAgents/org.saltstack.salt-minion.plist')

def update():

    # Better, but broken solution
    #
    # if not __opts__.get('master_ip', None):
    #   log.warning('restarting: master_ip is empty')
    #    return _restart()
    #

    ticks = __salt__['data.getval']('dynamic_dns:restart_ticks')
    ticks = ticks or 0
    log.warning('ticks... %s', ticks)
    __salt__['data.update']('dynamic_dns:restart_ticks', ticks + 1)
    if ticks % 11 == 0:
        log.warning('updating DNS!')
        return _restart()
    else:
        return {}
