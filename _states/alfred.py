# -*- coding: utf-8 -*-
'''
Manage Alfred 2 app
'''

import logging
import os
import plistlib
log = logging.getLogger(__name__)

try:
    plistlib.readPlistFromString
except AttributeError:
    raise Exception('plist: Python 3 is not supported')


DEFAULTS = {
    'defaultresults': {
        'scope': [
            '/Applications',
            '/Applications/Xcode.app/Contents/Applications',
            '/Developer/Applications',
            '/Library/PreferencePanes',
            '/System/Library/CoreServices/Applications',
            '/System/Library/PreferencePanes',
            '~/Library/Caches/Metadata',
            '~/Library/Mobile Documents',
            '~/Library/PreferencePanes'
        ]
    }
}


def _alfred_dirs():
    prefs_path = '~/Dropbox/Library/Application Support/Alfred 2/Alfred.alfredpreferences/preferences/local'
    path = os.path.expanduser(prefs_path)
    dirs = __salt__['file.readdir'](path)
    dirs = filter(lambda x: not x.startswith('.'), dirs)
    dirs = map(lambda x: os.path.join(path, x), dirs)
    return dirs


def _read(path):
    raw = open(path, 'r').read()
    return plistlib.readPlistFromString(raw)


def _write(path, contents):
    raw = plistlib.writePlistToString(contents)
    if not __opts__['test']:
        open(path, 'w').write(raw)
    return path


def _append(name, key, config):
    actions = []
    for alfred_dir in _alfred_dirs():
        alfred_path = os.path.join(alfred_dir, config)
        contents = _read(alfred_path)
        if key not in contents:
            contents[key] = DEFAULTS['defaultresults']['scope']
        if name not in contents[key]:
            contents[key].append(name)
            action = _write(alfred_path, contents)
            actions.append(action)
    if actions:
        changes = {'updated': actions}
    else:
        changes = {}
    return {
        'name': name,
        'changes': changes,
        'result': True,
        'comment': ''
    }

def defaultresults_scope_add(name):
    return _append(name,
        key='scope',
        config='features/defaultresults/prefs.plist')
