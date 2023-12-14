#!/usr/bin/env python3
'''
Import the VAULT secrets from stdin as a JSON.

    Requires packages:
    pip3 install argparse json hvac

Requires environment to be set:
    VAULT_ADDR - points to your vault server
    VAULT_TOKEN - you get it when you login into vault

To get these run `vault login -method=aws role=admin` and then set VAULT_TOKEN.

To copy secrets in dev to stage (after you do `vault login` in both) without
secrets being saved:

vault-export.py --vault-addr=https://vault.dev.clari.io --vault-token=XXXX | \
  vault-import.py --vault-addr=https://vault.stage.clari.io --vault-token=YYYYY
'''
from argparse import ArgumentParser
import hvac
import json
import os
import sys


def eprint(*args) -> None:
    print(*args, file=sys.stderr)
    return


def ingest(args, data) -> int:
    '''
    Export all the secrets to the stdout
    '''
    if not data:
        eprint('Nothing to import')
        return 1

    addr = args.vault_addr
    if not addr:
        eprint('VAULT_ADDR not set')
        return 1
    token = args.vault_token
    if token is None:
        eprint('VAULT_TOKEN not set')
        return 1

    client = hvac.Client(
        url=addr, token=token, verify=not args.skip_tls_verify)
    if not client.is_authenticated():
        eprint(
            'Failed to authenticate against', addr,
            'Re-login with `vault login -method=aws role=admin`')
        return 1

    for app, kv in data.items():
        client.secrets.kv.v2.create_or_update_secret(
            path=app, secret=kv)

    return 0


def main() -> int:
    '''
    Main entry point
    '''
    #
    # build the parser
    #
    ap = ArgumentParser(
        prog='vault-import', description='Import vault secrets from stdin as JSON')
    ap.add_argument(
        '-v', '--verbose', action='store_true', default=False,
        help='Tell more about what is going on')
    ap.add_argument(
        '--skip-tls-verify', action='store_true', default=False,
        help='Skip TLS Verification, defaults to false')
    ap.add_argument(
        '--vault-addr', default=os.getenv('VAULT_ADDR'),
        help='Vault address, defaults to env VAULT_ADDR')
    ap.add_argument(
        '--vault-token', default=os.getenv('VAULT_TOKEN'),
        help='Vault address, defaults to env VAULT_ADDR')
    #
    # parse the command line
    #
    args = ap.parse_args()
    try:
        return ingest(args, json.load(sys.stdin))

    except KeyboardInterrupt:
        eprint('Caught KeyboardInterrupt')

    return 1


if __name__ == '__main__':
    sys.exit(main())
