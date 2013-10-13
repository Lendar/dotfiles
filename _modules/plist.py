import os
import plistlib
import fnmatch
import time

import salt.utils

# OSX_PREFS = '~/Desktop'
OSX_PREFS = '~/Library/Preferences'


def plutil_load(src, format):
    dest = '-' # stdout
    args = ['plutil', '-convert', format, '-o', dest, '--', src]
    cmd = ' '.join(args)
    # run_stdout
    ret = __salt__['cmd.run'](cmd)
    return ret


def plutil_save(dest, format, raw_plist):
    src = '-' # stdin
    args = ['plutil', '-convert', format, '-o', dest, '--', src]
    cmd = ' '.join(args)
    # run_stdout
    ret = __salt__['cmd.run'](cmd, stdin=raw_plist)
    return ret


def parse(raw_plist):
    """returns a plist object from a file contents"""
    try:
        pl = plistlib.readPlistFromString(raw_plist)
    except AttributeError:
        raise Exception('Python 3 is not supported')
        # TODO:
        # try:
        #     pl = plistlib.readPlistFromBytes(raw_plist)
    return pl


def dump(obj):
    """returns a file contents from a plist object"""
    try:
        raw_plist = plistlib.writePlistToString(obj)
    except AttributeError:
        raise Exception('Python 3 is not supported')
    return raw_plist


def filterApps(apps):
    res = []
    for app in apps:
        if app['tile-data']['bundle-identifier'].startswith('com.apple'):
            res.append(app)
        if app['tile-data']['bundle-identifier'] == 'com.apple.calendar':
            res.append(app)
    return res


def remove_item(plist_name, key, array_key, array_value):
    "Find better fn name, standartize args. Unfinished"
    f = read(plist_name)
    for p in app[key]:
        if p == array_key and v == array_value:
             del app[p]
        print app
    write(plist_name, f)


def match_glob(s, patterns):
    for p in patterns:
        if fnmatch.fnmatch(s, p):
            return True
    return False


def remove_dock_app(names):
    if isinstance(names, basestring):
        names = [names]
    print names
    plist_name = 'com.apple.dock'
    dock = read(plist_name)
    apps = dock['persistent-apps']
    to_remove = []
    for app in apps:
        if match_glob(app['tile-data']['bundle-identifier'], names):
            print 'removing', app['tile-data']['bundle-identifier']
            to_remove.append(app)
    for app in to_remove:
        apps.remove(app)
    write(plist_name, dock)
    return {'removed': to_remove}


def persistent():
    read('com.apple.dock.plist')
    apps = pl['persistent-apps']
    return filterApps(apps)


def _normalize_path(name):
    # FIXME: test code
    # name = name or '~/Desktop/com.apple.dock.plist'
    if '/' not in name:
        name = os.path.join(OSX_PREFS, name)
    if not name.endswith('.plist'):
        name = name + '.plist'
    return name


def read(name):
    name = _normalize_path(name)
    # TODO: try to resolve path
    #   path = os.path.expanduser('~/Library/Preferences/com.apple.dock.plist')
    raw_plist = plutil_load(name, 'xml1')
    obj = parse(raw_plist)
    return obj


def write(name, obj):
    name = _normalize_path(name)
    raw_plist = dump(obj)
    print raw_plist
    plutil_save(name, 'binary1', raw_plist)


def read_defaults(name, var):
    cmd = 'defaults read {name} {var}'.format(
        name=name, var=var)
    ret = __salt__['cmd.run'](cmd)
    return ret


def main():
    readPlist(path)
    # removeItem('', 'arrr', )


if __name__ == '__main__':
    print 'Usage:'
    print '    salt \* saltutil.sync_modules;salt-call plist.remove_dock_app "com.apple.*"'
    print ''
    print 'To see changes:'
    print '    killall dock'
    main()
