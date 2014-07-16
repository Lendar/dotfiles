import fnmatch

PLIST_NAME = 'com.apple.dock'


def _match_glob(s, patterns):
    for p in patterns:
        if fnmatch.fnmatch(s, p):
            return True
    return False


def remove_dock_app(names):
    "Example usage: remove_dock_app('com.apple.*')"
    if isinstance(names, basestring):
        names = [names]
    print names
    dock = __salt__['plist.load'](PLIST_NAME)
    apps = dock['persistent-apps']
    to_remove = []
    for app in apps:
        if _match_glob(app['tile-data']['bundle-identifier'], names):
            print 'removing', app['tile-data']['bundle-identifier']
            to_remove.append(app)
    for app in to_remove:
        apps.remove(app)
    __salt__['plist.dump'](dock, PLIST_NAME)
    return {'removed': to_remove}
