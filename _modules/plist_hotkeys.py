PLIST_NAME = 'com.apple.symbolichotkeys'


def is_hotkey_enabled(hotkey_id):
    hotkeys = __salt__['plist.load'](PLIST_NAME)
    return hotkeys['AppleSymbolicHotKeys'][str(hotkey_id)]['enabled']


def _toggle_hotkey(hotkey_id, value):
    hotkeys = __salt__['plist.load'](PLIST_NAME)
    hotkeys['AppleSymbolicHotKeys'][str(hotkey_id)]['enabled'] = bool(value)
    __salt__['plist.dump'](hotkeys, PLIST_NAME)
    return True


def disable_hotkey(hotkey_id):
    return _toggle_hotkey(hotkey_id, False)


def enable_hotkey(hotkey_id):
    return _toggle_hotkey(hotkey_id, True)
