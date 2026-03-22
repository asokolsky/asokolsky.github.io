# Installing and using NVIDIA NemoClaw

[NemoClaw](https://github.com/NVIDIA/NemoClaw)

## Prerequisites

Install [node](node.html) for the user NOT globally.

Install [docker](docker/) and make sure `docker ps` does not require sudo.

Install [OpenShell](https://github.com/NVIDIA/OpenShell):

```sh
curl -LsSf https://raw.githubusercontent.com/NVIDIA/OpenShell/main/install.sh | sh
```
which gives:

```
alex@exi > curl -LsSf https://raw.githubusercontent.com/NVIDIA/OpenShell/main/install.sh | sh
openshell: resolving latest version...
openshell: downloading openshell v0.0.11 (x86_64-unknown-linux-musl)...
openshell: verifying checksum...
openshell: extracting...
openshell: installed openshell 0.0.11 to /home/alex/.local/bin/openshell
```

Verify OpenShell install:

```
> openshell --version
openshell 0.0.10
```

## Installation

```sh
curl -fsSL https://www.nvidia.com/nemoclaw.sh | bash
```

which gives:
```
alex@exi > curl -fsSL https://www.nvidia.com/nemoclaw.sh | bash
[INFO]  === NemoClaw Installer ===
[INFO]  Node.js found: v24.14.0
[INFO]  Runtime OK: Node.js v24.14.0, npm 11.9.0
[INFO]  Installing NemoClaw from GitHub…
npm warn deprecated node-domexception@1.0.0: Use your platform's native DOMException instead

changed 642 packages in 19s

122 packages are looking for funding
  run `npm fund` for details
[INFO]  Verified: nemoclaw is available at /home/alex/.n/bin/nemoclaw
[INFO]  Running nemoclaw onboard…
[INFO]  Installer stdin is piped; attaching onboarding to /dev/tty…

  NemoClaw Onboarding
  ===================

  [1/7] Preflight checks
  ──────────────────────────────────────────────────
  ✓ Docker is running
  ✓ Container runtime: docker
  ✓ openshell CLI: openshell 0.0.11
  ✓ Port 8080 available (OpenShell gateway)
  ✓ Port 18789 available (NemoClaw dashboard)
  ✓ NVIDIA GPU detected: 1 GPU(s), 8192 MB VRAM

  [2/7] Starting OpenShell gateway
  ──────────────────────────────────────────────────
✓ Checking Docker
✓ Downloading gateway
✓ Initializing environment
✓ Starting gateway
✓ Gateway ready

  Name: nemoclaw
  Endpoint: https://127.0.0.1:8080

✓ Active gateway set to 'nemoclaw'
  ✓ Gateway is healthy

  [3/7] Creating sandbox
  ──────────────────────────────────────────────────
  Sandbox name (lowercase, numbers, hyphens) [my-assistant]:
  Creating sandbox 'my-assistant' (this takes a few minutes on first run)...
Building image openshell/sandbox-from:1773962852 from /tmp/nemoclaw-build-D3ohEu/Dockerfile
  Context: /tmp/nemoclaw-build-D3ohEu
  Gateway: nemoclaw

  Building image openshell/sandbox-from:1773962852 from /tmp/nemoclaw-build-D3ohEu/Dockerfile
  Step 1/22 : FROM node:22-slim
   ---> 4f77a690f2f8
  Step 2/22 : ENV DEBIAN_FRONTEND=noninteractive
   ---> Running in fd178bb77e23
   ---> Removed intermediate container fd178bb77e23
   ---> f73beb704fca
  Step 3/22 : RUN apt-get update && apt-get install -y --no-install-recommends  python3 python3-pip python3-venv curl git ca-certificates iproute2 && rm -rf /var/lib/apt/lists/*
   ---> Running in a5e02fee41ab

  Fetched 9348 kB in 1s (8782 kB/s)
Reading package lists...
  Reading package lists...
  Building dependency tree...

Reading state information...
  The following additional packages will be installed:
  git-man libbpf1 libbrotli1 libbsd0 libcap2-bin libcurl3-gnutls libcurl4
  libelf1 liberror-perl libexpat1 libgdbm-compat4 libgdbm6 libgssapi-krb5-2
  libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libldap-2.5-0 libmnl0
  libncursesw6 libnghttp2-14 libnsl2 libperl5.36 libpsl5 libpython3-stdlib
    libpython3.11-minimal libpython3.11-stdlib libreadline8 librtmp1 libsasl2-2
  libsasl2-modules-db libsqlite3-0 libssh2-1 libssl3 libtirpc-common libtirpc3
    libxtables12 media-types openssl perl perl-modules-5.36 python3-distutils
  python3-lib2to3 python3-minimal python3-pip-whl python3-pkg-resources
  python3-setuptools python3-setuptools-whl python3-wheel python3.11
  python3.11-minimal python3.11-venv readline-common
  Suggested packages:
  gettext-base git-daemon-run | git-daemon-sysvinit git-doc git-email git-gui
  gitk gitweb git-cvs git-mediawiki git-svn iproute2-doc gdbm-l10n krb5-doc
  krb5-user sensible-utils perl-doc libterm-readline-gnu-perl
  | libterm-readline-perl-perl make libtap-harness-archive-perl python3-doc
  python3-tk python-setuptools-doc python3.11-doc binutils binfmt-support
  readline-doc
Recommended packages:
  patch less ssh-client libatm1 libpam-cap krb5-locales libldap-common libgpm2
  publicsuffix libsasl2-modules netbase build-essential python3-dev
  The following NEW packages will be installed:
    ca-certificates curl git git-man iproute2 libbpf1 libbrotli1 libbsd0
  libcap2-bin libcurl3-gnutls libcurl4 libelf1 liberror-perl libexpat1
    libgdbm-compat4 libgdbm6 libgssapi-krb5-2 libk5crypto3 libkeyutils1
    libkrb5-3 libkrb5support0 libldap-2.5-0 libmnl0 libncursesw6 libnghttp2-14
    libnsl2 libperl5.36 libpsl5 libpython3-stdlib libpython3.11-minimal
    libpython3.11-stdlib libreadline8 librtmp1 libsasl2-2 libsasl2-modules-db
    libsqlite3-0 libssh2-1 libssl3 libtirpc-common libtirpc3 libxtables12
    media-types openssl perl perl-modules-5.36 python3 python3-distutils
  python3-lib2to3 python3-minimal python3-pip python3-pip-whl
    python3-pkg-resources python3-setuptools python3-setuptools-whl python3-venv
    python3-wheel python3.11 python3.11-minimal python3.11-venv readline-common
  0 upgraded, 60 newly installed, 0 to remove and 0 not upgraded.
Need to get 36.5 MB of archives.
After this operation, 158 MB of additional disk space will be used.

  debconf: delaying package configuration, since apt-utils is not installed

  Fetched 36.5 MB in 1s (38.2 MB/s)
  Selecting previously unselected package perl-modules-5.36.
(Reading database ... 6096 files and directories currently installed.)
  Setting up python3.11-minimal (3.11.2-6+deb12u6) ...
  Selecting previously unselected package python3-minimal.
(Reading database ... 8428 files and directories currently installed.)
(Reading database ... 8936 files and directories currently installed.)
Running hooks in /etc/ca-certificates/update.d...
  done.
   ---> Removed intermediate container a5e02fee41ab
   ---> 7ac11f6797c6
  Step 4/22 : RUN groupadd -r sandbox && useradd -r -g sandbox -d /sandbox -s /bin/bash sandbox     && mkdir -p /sandbox/.openclaw /sandbox/.nemoclaw     && chown -R sandbox:sandbox /sandbox
   ---> Running in 6e7ec133e478
   ---> Removed intermediate container 6e7ec133e478
   ---> 0ac3eedd7ce4
  Step 5/22 : RUN npm install -g openclaw@2026.3.11
   ---> Running in 547f755b162f
  npm warn deprecated node-domexception@1.0.0: Use your platform's native DOMException instead


added 656 packages in 19s

122 packages are looking for funding
  run `npm fund` for details
  npm notice
npm notice New major version of npm available! 10.9.4 -> 11.12.0
npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.12.0
npm notice To update run: npm install -g npm@11.12.0
npm notice

   ---> Removed intermediate container 547f755b162f
   ---> 34c5c4cbc78a
  Step 6/22 : RUN pip3 install --break-system-packages pyyaml
   ---> Running in 9ca9b3995302
  Collecting pyyaml
    Downloading pyyaml-6.0.3-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (806 kB)
       ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 806.6/806.6 kB 7.1 MB/s eta 0:00:00
  Installing collected packages: pyyaml
  Successfully installed pyyaml-6.0.3
  WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

   ---> Removed intermediate container 9ca9b3995302
   ---> 82de9545c55e
  Step 7/22 : COPY nemoclaw/dist/ /opt/nemoclaw/dist/
   ---> 307ac94448dd
  Step 8/22 : COPY nemoclaw/openclaw.plugin.json /opt/nemoclaw/
   ---> 2adc7d7560e5
  Step 9/22 : COPY nemoclaw/package.json /opt/nemoclaw/
   ---> 71ed2490b51e
  Step 10/22 : COPY nemoclaw-blueprint/ /opt/nemoclaw-blueprint/
   ---> 62987fb056e2
  Step 11/22 : WORKDIR /opt/nemoclaw
   ---> Running in 865591a7cd36
   ---> Removed intermediate container 865591a7cd36
   ---> 0228447746b2
  Step 12/22 : RUN npm install --omit=dev
   ---> Running in 1e464f54f003

added 9 packages, and audited 10 packages in 6s

1 package is looking for funding
  run `npm fund` for details

found 0 vulnerabilities
   ---> Removed intermediate container 1e464f54f003
   ---> a2baa6b1d28d
  Step 13/22 : RUN mkdir -p /sandbox/.nemoclaw/blueprints/0.1.0     && cp -r /opt/nemoclaw-blueprint/* /sandbox/.nemoclaw/blueprints/0.1.0/
   ---> Running in 234569aaa272
   ---> Removed intermediate container 234569aaa272
   ---> 03f2b2df423a
  Step 14/22 : COPY scripts/nemoclaw-start.sh /usr/local/bin/nemoclaw-start
   ---> 6e077b9f744d
  Step 15/22 : RUN chmod +x /usr/local/bin/nemoclaw-start
   ---> Running in b5820c13624d
   ---> Removed intermediate container b5820c13624d
   ---> fbf5be3c3ffc
  Step 16/22 : WORKDIR /sandbox
   ---> Running in d0a3f35606b1
   ---> Removed intermediate container d0a3f35606b1
   ---> 249df551eb0a
  Step 17/22 : USER sandbox
   ---> Running in b20081ac9f5d
   ---> Removed intermediate container b20081ac9f5d
   ---> 167e959c9dd7
  Step 18/22 : RUN mkdir -p /sandbox/.openclaw/agents/main/agent     && chmod 700 /sandbox/.openclaw
   ---> Running in ec36fe742036
   ---> Removed intermediate container ec36fe742036
   ---> b008c6820108
  Step 19/22 : RUN python3 -c "import json, os; config = {     'agents': {'defaults': {'model': {'primary': 'nvidia/nemotron-3-super-120b-a12b'}}},     'models': {'mode': 'merge', 'providers': {'nvidia': {         'baseUrl': 'https://inference.local/v1',         'apiKey': 'openshell-managed',         'api': 'openai-completions',         'models': [{'id': 'nemotron-3-super-120b-a12b', 'name': 'NVIDIA Nemotron 3 Super 120B', 'reasoning': False, 'input': ['text'], 'cost': {'input': 0, 'output': 0, 'cacheRead': 0, 'cacheWrite': 0}, 'contextWindow': 131072, 'maxTokens': 4096}]     }}} }; path = os.path.expanduser('~/.openclaw/openclaw.json'); json.dump(config, open(path, 'w'), indent=2); os.chmod(path, 0o600)"
   ---> Running in 1270a46e2272
   ---> Removed intermediate container 1270a46e2272
   ---> ac2e4fea2243
  Step 20/22 : RUN openclaw doctor --fix > /dev/null 2>&1 || true     && openclaw plugins install /opt/nemoclaw > /dev/null 2>&1 || true
   ---> Running in e513a0eb9d9c
   ---> Removed intermediate container e513a0eb9d9c
   ---> a3f6edc63bfd
  Step 21/22 : ENTRYPOINT ["/bin/bash"]
   ---> Running in 56ff51d62def
   ---> Removed intermediate container 56ff51d62def
   ---> 010746f585a3
  Step 22/22 : CMD []
   ---> Running in 36d60a2c2cde
   ---> Removed intermediate container 36d60a2c2cde
   ---> 046fef9c9913
  Successfully built 046fef9c9913
  Successfully tagged openshell/sandbox-from:1773962852
  Built image openshell/sandbox-from:1773962852
  Pushing image openshell/sandbox-from:1773962852 into gateway "nemoclaw"
  [progress] Exported 1173 MiB
  [progress] Uploaded to gateway
  Image openshell/sandbox-from:1773962852 is available in the gateway.

✓ Image openshell/sandbox-from:1773962852 is available in the gateway.

Created sandbox: my-assistant
Setting up NemoClaw...
[gateway] openclaw gateway launched (pid 83)
[gateway] auto-pair watcher launched (pid 84)
[gateway] Local UI: http://127.0.0.1:18789/
[gateway] Remote UI: http://127.0.0.1:18789/
  Waiting for sandbox to become ready...
✓ Forwarding port 18789 to sandbox my-assistant in the background
  Access at: http://127.0.0.1:18789/
  Stop with: openshell forward stop 18789 my-assistant
  ✓ Sandbox 'my-assistant' created

  [4/7] Configuring inference (NIM)
  ──────────────────────────────────────────────────

  Inference options:
    1) NVIDIA Cloud API (build.nvidia.com) (recommended)
    2) Local Ollama (localhost:11434)

  Choose [1]: 2
  Starting Ollama...
  ✓ Using Ollama on localhost:11434

  Ollama models:
    1) nemotron-3-nano:30b

  Choose model [1]:

  [5/7] Setting up inference provider
  ──────────────────────────────────────────────────
✓ Created provider ollama-local
Gateway inference configured:

  Route: inference.local
  Provider: ollama-local
  Model: nemotron-3-nano:30b
  Version: 1
  Priming Ollama model: nemotron-3-nano:30b
  Selected Ollama model 'nemotron-3-nano:30b' failed the local probe: model 'nemotron-3-nano:30b' not found
```
