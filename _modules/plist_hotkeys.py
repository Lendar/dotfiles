PLIST_NAME = 'com.apple.symbolichotkeys'


def _get_hotkey(hotkeys, hotkey_id):
    symbolichotkeys = hotkeys['AppleSymbolicHotKeys']
    key = str(hotkey_id)
    if key in symbolichotkeys:
        return symbolichotkeys[key]
    else:
        return None


def _add_hotkey(hotkeys, hotkey_id, value):
    symbolichotkeys = hotkeys['AppleSymbolicHotKeys']
    key = str(hotkey_id)
    if key in symbolichotkeys:
        raise Exception('_set_hotkey conflicted key')
    else:
        symbolichotkeys[key] = value


def is_hotkey_enabled(hotkey_id):
    hotkeys = __salt__['plist.load'](PLIST_NAME)
    matched_hotkey = _get_hotkey(hotkeys, hotkey_id)
    if matched_hotkey is None:
        return None
    return matched_hotkey['enabled']


def _toggle_hotkey(hotkey_id, value):
    hotkeys = __salt__['plist.load'](PLIST_NAME)
    hotkey_config = _get_hotkey(hotkeys, hotkey_id)
    if hotkey_config is not None:
        hotkey_config['enabled'] = bool(value)
    else:
        hotkey_config = {'enabled': bool(value)}
        _add_hotkey(hotkeys, hotkey_id, hotkey_config)
    __salt__['plist.dump'](hotkeys, PLIST_NAME)
    return True


def disable_hotkey(hotkey_id):
    return _toggle_hotkey(hotkey_id, False)


def enable_hotkey(hotkey_id):
    return _toggle_hotkey(hotkey_id, True)
