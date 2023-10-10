from getpass import getpass
from os import getenv
from sys import stdin
from typing import Tuple


def get_username_password(username: str = '') -> Tuple[str, str]:
    '''
    Collects user password from stdin and returns a tuple (username, password).
    Works in emacs inferior shell and other weird places.

    Can be used to collect credentials for requests lib:
        requests.get(url, auth=get_username_password())
    '''

    def get_default_username() -> str:
        '''
        Try to deduce username
        '''
        for env in ['SUDO_USER', 'USER', 'LOGNAME']:
            username = getenv(env, '')
            if username:
                return username

        return ''

    if not username:
        username = get_default_username()
    pw = ''
    if stdin.isatty():
        pw = getpass(prompt=f'Password for {username}: ', stream=None)
    else:
        line = stdin.readline()
        pw = line.rstrip()
    return (username, pw)
