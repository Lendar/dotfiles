PLIST_NAME = 'com.apple.symbolichotkeys'


def _get_hotkey(hotkeys, hotkey_id):
    symbolichotkeys = hotkeys['AppleSymbolicHotKeys']
    key = str(hotkey_id)
    if key in symbolichotkeys:
        return symbolichotkeys[key]
    else:
        return None


def is_hotkey_enabled(hotkey_id):
    hotkeys = __salt__['plist.load'](PLIST_NAME)
    matched_hotkey = _get_hotkey(hotkeys, hotkey_id)
    if matched_hotkey is None:
        return False
    return matched_hotkey['enabled']


def _toggle_hotkey(hotkey_id, value):
    hotkeys = __salt__['plist.load'](PLIST_NAME)
    _get_hotkey(hotkeys, hotkey_id)['enabled'] = bool(value)
    __salt__['plist.dump'](hotkeys, PLIST_NAME)
    return True


def disable_hotkey(hotkey_id):
    return _toggle_hotkey(hotkey_id, False)


def enable_hotkey(hotkey_id):
    return _toggle_hotkey(hotkey_id, True)
