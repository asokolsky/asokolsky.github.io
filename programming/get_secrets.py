import os
import stat
from configparser import ConfigParser
from os.path import isfile, abspath, expanduser
from typing import Any, Dict, Optional, Tuple
#
# Simple API to access secretes stored, e.g. in a ~/.secrets INI file.
#
# TODO: generalize it, so that instead a local file system an AWS S3 bucket
# could be used to store secrets
#
def get_secrets(realm:str, file_name: Optional[str]=None) -> Tuple[
        Optional[Dict[str, Any]], Optional[str], Optional[str]]:
    '''
    Get secrets for the _realm_ from an INI file _file_name_
    In: _realm_ is a non-empty string
    In: _file_name_:
        if None, defaults to '.secrets'.
        If starts with /, ./ or ~ it is treated as an absolute path.
        Otherwise the following locations will be checked:
        1. current directory. If located, further search is aborted.
        2. user home directory

    Returns a tuple: (secrets-dict, secrets-file-path, errmsg)

    secrets-dictionary is a representation of the section <realm> in
      the secrets INI file.
    secrets-file-path is an absolute path to the secrets file.
    errmsg: is None or an error message
    '''

    def find_file(file_name: str) -> Optional[str]:
        '''
        Try to locate file_name first in current then in user home dir.
        If starts with / or ~ is treated as an absolute path.
        Returns abs path to file if succeeds.  None otherwise.
        '''
        for p in ('~', '/', '..', './'):
            if file_name.startswith(p):
                if isfile( file_name ):
                    return abspath( file_name )
                return None

        # try to find file_name at the following locations:
        for loc in ('./',  expanduser('~/')):
            fpath = abspath( loc + file_name )
            if isfile(fpath):
                return fpath

        return None

    def verify_file(fpath: str) -> str:
        '''
        Verify secrets file path, permissions-should be readable by owner only.
        Returns errmsg, empty string for success
        '''
        mode = os.stat(fpath).st_mode
        if stat.S_IMODE(mode) & (stat.S_IRGRP|stat.S_IROTH):
            return 'Secrets are readable by group or others'

        return ''

    if not isinstance(realm, str):
        return None, None, 'realm should be a string'
    elif not realm:
        return None, None, 'realm should be a non-empty string'

    if file_name is None:
        file_name = '.secrets'
    elif not isinstance( file_name, str ):
        return None, None, 'file_name should be a string'
    elif not file_name:
        return None, None, 'file_name should be a non-empty string'

    fpath = find_file(file_name)
    if fpath is None:
        return None, None, f"Failed to find '{file_name}'"

    errmsg = verify_file( fpath )
    if errmsg:
        return None, fpath, errmsg
    #
    cfgp = ConfigParser()
    try:
        cfgp.read( fpath )
    except Exception as ex:
        return None, fpath, f'Bad syntax: {ex}'

    if realm not in cfgp.sections():
        return None, fpath, f'Failed to locate {realm} secrets'

    res:Dict[str, Any] = {}
    for option in cfgp.options(realm):
        res[option] = cfgp.get(realm, option)

    return res, fpath, None
