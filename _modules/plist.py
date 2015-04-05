import os
import plistlib

try:
    plistlib.readPlistFromString
except AttributeError:
    raise Exception('plist: Python 3 is not supported')

OSX_PREFS = '~/Library/Preferences'


def plutil_bin2xml(src, format):
    dest = '-' # stdout
    args = ['plutil', '-convert', format, '-o', dest, '--', src]
    cmd = ' '.join(args)
    ret = __salt__['cmd.run_stdout'](cmd, output_loglevel='quiet')
    return ret


def plutil_xml2bin(dest, format, raw_plist):
    src = '-' # stdin
    args = ['plutil', '-convert', format, '-o', dest, '--', src]
    cmd = ' '.join(args)
    ret = __salt__['cmd.run'](cmd, stdin=raw_plist)
    return ret


def parse_xml(raw_plist):
    """returns a plist object from a file contents"""
    pl = plistlib.readPlistFromString(raw_plist)
    return pl


def dump_xml(obj):
    """returns a file contents from a plist object"""
    raw_plist = plistlib.writePlistToString(obj)
    return raw_plist


def _normalize_path(name):
    if '/' not in name:
        name = os.path.join(OSX_PREFS, name)
    if not name.endswith('.plist'):
        name = name + '.plist'
    name = os.path.expanduser(name)
    return name


def load(filename):
    filename = _normalize_path(filename)
    raw_plist = plutil_bin2xml(filename, 'xml1')
    contents = parse_xml(raw_plist)
    return contents


def dump(contents, filename):
    filename = _normalize_path(filename)
    raw_plist = dump_xml(contents)
    plutil_xml2bin(filename, 'binary1', raw_plist)
    return True
