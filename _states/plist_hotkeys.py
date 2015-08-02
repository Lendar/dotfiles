def disable_hotkey(name):
    ret = {
        'name': name,
        'changes': {},
        'result': True,
        'comment': ''
    }
    try:
        enabled = __salt__['plist_hotkeys.is_hotkey_enabled'](name)
        if enabled != False:
            ret['changes'][name] = 'disabled'
            if __opts__['test']:
                ret['result'] = None
                ret['comment'] = 'Would disable hotkey #{0}'.format(name)
            else:
                ret['comment'] = 'Disabled hotkey #{0}'.format(name)
                __salt__['plist_hotkeys.disable_hotkey'](name)
        return ret
    except Exception as e:
        ret['result'] = False
        ret['comment'] = repr(e)
        return ret
