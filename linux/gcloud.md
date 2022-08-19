# gcloud UX exercise

## Installing Prerequistites

Followed [docs](https://cloud.google.com/sdk/docs/install):

```
alex@latitude7490:~/Projects/asokolsky.github.io/ > python3 --version
Python 3.10.4
alex@latitude7490:~/Projects/asokolsky.github.io/ > curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-398.0.0-linux-x86_64.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
alex@latitude7490:~/Projects/asokolsky.github.io/ > tar -xf google-cloud-cli-398.0.0-linux-x86_64.tar.gz
alex@latitude7490:~/Projects/asokolsky.github.io/ > ./google-cloud-sdk/install.sh
alex@latitude7490:~/Projects/asokolsky.github.io/ > ./google-cloud-sdk/bin/gcloud init
Welcome! This command will take you through the configuration of gcloud.

Your current configuration has been set to: [default]

You can skip diagnostics next time by using the following flag:
  gcloud init --skip-diagnostics

Network diagnostic detects and fixes local network connection issues.
Checking network connection...done.
Reachability Check passed.
Network diagnostic passed (1/1 checks passed).

You must log in to continue. Would you like to log in (Y/n)?

Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=32555940559.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsqlservice.login+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&state=x3fSBaMmKId42YpBzuQtD99EO0wFVS&access_type=offline&code_challenge=uGx1Uc-aK7rFSsvew6eOn6taAKHMNXl7e0YH1PrpQVc&code_challenge_method=S256

You are logged in as: [cw-devs-aug22-p10@clouduxtesting.com].

Pick cloud project to use:
 [1] cw-devs-aug22
 [2] Enter a project ID
 [3] Create a new project
Please enter numeric choice or text value (must exactly match list item):  1

Your current project has been set to: [cw-devs-aug22].

Not setting default zone/region (this feature makes it easier to use
[gcloud compute] by setting an appropriate default value for the
--zone and --region flag).
See https://cloud.google.com/compute/docs/gcloud-compute section on how to set
default compute region and zone manually. If you would like [gcloud init] to be
able to do this for you the next time you run it, make sure the
Compute Engine API is enabled for your project on the
https://console.developers.google.com/apis page.

Created a default .boto configuration file at [/home/alex/.boto]. See this file and
[https://cloud.google.com/storage/docs/gsutil/commands/config] for more
information about configuring Google Cloud Storage.
Your Google Cloud SDK is configured and ready to use!

* Commands that require authentication will use cw-devs-aug22-p10@clouduxtesting.com by default
* Commands will reference project `cw-devs-aug22` by default
Run `gcloud help config` to learn how to change individual settings

This gcloud configuration is called [default]. You can create additional configurations if you work with multiple accounts and/or projects.
Run `gcloud topic configurations` to learn more.

Some things to try next:

* Run `gcloud --help` to see the Cloud Platform services you can interact with. And run `gcloud help COMMAND` to get help on any gcloud command.
* Run `gcloud topic --help` to learn about advanced features of the SDK like arg files and output formatting
* Run `gcloud cheat-sheet` to see a roster of go-to `gcloud` commands.
```

Installed `alpha` components:
```
alex@latitude7490:~/Projects/asokolsky.github.io/ > gcloud components install alpha


Your current Google Cloud CLI version is: 398.0.0
Installing components from version: 398.0.0

┌──────────────────────────────────────────────┐
│     These components will be installed.      │
├───────────────────────┬────────────┬─────────┤
│          Name         │  Version   │   Size  │
├───────────────────────┼────────────┼─────────┤
│ gcloud Alpha Commands │ 2022.08.12 │ < 1 MiB │
└───────────────────────┴────────────┴─────────┘

For the latest full release notes, please visit:
  https://cloud.google.com/sdk/release_notes

Do you want to continue (Y/n)?

╔════════════════════════════════════════════════════════════╗
╠═ Creating update staging area                             ═╣
╠════════════════════════════════════════════════════════════╣
╠═ Installing: gcloud Alpha Commands                        ═╣
╠════════════════════════════════════════════════════════════╣
╠═ Creating backup and activating new installation          ═╣
╚════════════════════════════════════════════════════════════╝

Performing post processing steps...done.

Update done!
```

Finally:

```
alex@latitude7490:~/Projects/asokolsky.github.io/ > gcloud --version
Google Cloud SDK 398.0.0
alpha 2022.08.12
bq 2.0.75
core 2022.08.12
gcloud-crc32c 1.0.0
gsutil 5.12
```

## To Be Used Later

Created `main.py` as advised.


Preview with port forwarding. Start a tcp tunnel on port 8080 with

```
export PROJECT=cw-devs-aug22
export WORKSTATION_CLUSTER_REGION=us-central1
export WORKSTATION_CLUSTER_ID=uxr-cluster
export WORKSTATION_ID=??

gcloud alpha workstations start-tcp-tunnel --project=${PROJECT} \
    --region=${WORKSTATION_CLUSTER_REGION} \
    --cluster=${WORKSTATION_CLUSTER_ID} \
    ${WORKSTATION_ID} 8080 --local-host-port=127.0.0.1:8080
```

Then open localhost:8080 on a browser window

USE THE FOLLOWING INSTRUCTIONS FOR THE TASK:

Connect to your workstation via SSH.
Start a tcp tunnel on remote port 22

gcloud alpha workstations start-tcp-tunnel --project=${PROJECT} \
    --region=${WORKSTATION_CLUSTER_REGION} \
    --cluster=${WORKSTATION_CLUSTER_ID} \
    ${WORKSTATION_ID} 22 --local-host-port=127.0.0.1:2222


Then run

```
ssh user@127.0.0.1 -p 2222
```

## Study

My laptop:

```
alex@latitude7490:~/Projects/asokolsky.github.io/ > cat /etc/lsb-release
DISTRIB_ID=LinuxMint
DISTRIB_RELEASE=21
DISTRIB_CODENAME=vanessa
DISTRIB_DESCRIPTION="Linux Mint 21 Vanessa"
alex@latitude7490:~/Projects/asokolsky.github.io/ > uname -a
Linux latitude7490 5.15.0-46-generic #49-Ubuntu SMP Thu Aug 4 18:03:25 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```

When https://s2.userzoom.com/u/NyBDNTE4N1MzOTM2 is opened in Firefox
103.0.2 (64-bit) (also configured as the default browser) Installing extension
fails:
https://cdn4.userzoom.com/addon/ff/userzoom_surveys-6.0.0-fx.xpi
results in 404


When Chrome Version 104.0.5112.101 (Official Build) (64-bit) is used:

* extension installed;
* microphone is verified to work ok;
* my laptop is connected to a single monitor, lid is closed, hence I have a
single screen which I agree to share;
* a full screen window is opened with:

```
This survey cannot be displayed in a frame. To open in a new window click here
Loading...
Uploading data...
This is taking a bit longer than expected, please hang tight and don’t close this tab.
```

and then:

```
Oops! We've detected a problem with your browser
Please try the following:

Remember that to do the study you need to allow to share your screen.
Check if your webcam and microphone is working properly.
Close any windows or tabs in your browser that are not necessary for the study.
Close any programs that are not necessary for the study.
Restart your browser or, restart your computer and click on your invitation link again.
If none of this works, please try completing the study from a different device.
When you're ready click on Continue, we'll take you through a quick system check to make sure everything is working fine.
```

## Troubleshooting:

* disabled pfBlockerNG `pfb_dnsbl` service and `pfb_filter` firewall filter
service
* restarted the laptop
* disabled firewall:

```
alex@latitude7490:~/Projects/asokolsky.github.io/ > sudo ufw status
[sudo] password for alex:
Status: inactive
alex@latitude7490:~/Projects/asokolsky.github.io/ > sudo ufw disable
Firewall stopped and disabled on system startup
alex@latitude7490:~/Projects/asokolsky.github.io/ > sudo ufw status
Status: inactive
```

All to no avail.  Looks like attempt to communicate to the survey server fails.
