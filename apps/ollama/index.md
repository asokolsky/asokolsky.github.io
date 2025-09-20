# Llama

Reference: [ubuntu-22-04-from-zero-to-70b-llama](https://forum.level1techs.com/t/ubuntu-22-04-from-zero-to-70b-llama-with-both-nvidia-and-amd-7xxx-series-gpus/206411).

## Prerequsites

* update OS
* ensure you can ssh into the machine

```sh
sudo apt update
sudo apt install python3-pip
```

My current OS:

```
> lsb_release -a
No LSB modules are available.
Distributor ID: Linuxmint
Description:    Linux Mint 22.1
Release:        22.1
Codename:       xia
```

## Install CUDA Toolkit

https://developer.nvidia.com/cuda-downloads

Make your choices, then:

```sh
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8
```

## Venv

```sh
python3 -m venv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
```

Check it:

```
(.venv)  alex@exi  ~/Projects/pytorch  python3 -c "import torch; print(torch.cuda.device_count())"
1
```

## Install ollama

https://github.com/ollama/ollama

```sh
curl https://ollama.ai/install.sh | sh
```

```
>>> Installing ollama to /usr/local
[sudo] password for alex:
>>> Downloading Linux amd64 bundle
######################################################################## 100.0%
>>> Creating ollama user...
>>> Adding ollama user to render group...
>>> Adding ollama user to video group...
>>> Adding current user to ollama group...
>>> Creating ollama systemd service...
>>> Enabling and starting ollama service...
Created symlink /etc/systemd/system/default.target.wants/ollama.service → /etc/systemd/system/ollama.service.
>>> NVIDIA GPU installed.
```

Then:
```sh
ollama run codellama:70b
```
