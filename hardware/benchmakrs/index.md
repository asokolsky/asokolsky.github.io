# PC Hardware Benchmarking

## PyPerformance

https://pyperformance.readthedocs.io

### Latitude 7490

[Latitude 7490](../dell/latitude-7490.html) runs Python 3.10.12.

Installed python 3.12 with headers:
```sh
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.12 python3.12-dev
```
Then install pip:
```sh
wget https://bootstrap.pypa.io/get-pip.py
python3.12 get-pip.py
```
verify:
```
> pip3 --version
pip 24.1.1 from /home/alex/.local/lib/python3.12/site-packages/pip (python 3.12)
```

Install pyperformance:
```sh
python3.12 -m pip install pyperformance
```

System Configuration:
```
{% include_relative latitude-pyperf-config.txt %}
```

Tuning was NOT done to preserve the power efficiency of the laptop.

Run performance test:
```sh
pyperformance run --python=/usr/bin/python3.12 -o latitude.json
```

### Thinkpad P52

[Thinkpad P52](../lenovo/thinkpad-p52.html) runs Python 3.10.12.

Installed Python 3.12.2 using `pyenv`, then:
```
alex@p52 > ~/Projects/pyperf > pyenv versions
  system
  3.12.2
* 3.12.4 (set by /home/alex/Projects/pyperf/.python-version)
```
and
```
alex@p52 > ~/Projects/pyperf > python --version
Python 3.12.4
```
Install pip for python 3.12:
```sh
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
```
verify:
```
alex@p52 > ~/Projects/pyperf > python -m pip --version
pip 24.1.2 from /home/alex/.pyenv/versions/3.12.4/lib/python3.12/site-packages/pip (python 3.12)
```
Install pyperformance:
```sh
python -m pip install pyperformance
```

System Configuration:
```
{% include_relative p52-pyperf-config.txt %}
```
Tuning was NOT done to preserve the power efficiency of the laptop.

Run performance test:
```sh
pyperformance run --python=~/.pyenv/shims/python -o p52.json
```

### Thinkpad T14 Gen 3 running Windows

[Thinkpad T14 Gen 3](../lenovo/thinkpad-t14g3.md) with Windows and Python 3.12.4 installed

System configuration does not work:
```
{% include_relative t14g3win-pyperf-config.txt %}
```

Run performance test:
```sh
pyperformance run -o t14g3win.json
```

### MacBook Pro 16" 2019

```
asokolsky@USSJC-ASOKOLSKY > ~/Projects/asokolsky.github.io | main ± > pyenv versions
  system
  3.10.1
* 3.12.2 (set by /Users/asokolsky/Projects/asokolsky.github.io/.python-version)
asokolsky@USSJC-ASOKOLSKY > ~/Projects/asokolsky.github.io | main ± > pyenv exec python --version
Python 3.12.2
```
then
```
wget https://bootstrap.pypa.io/get-pip.py
pyenv exec python get-pip.py
```
verify:
```
asokolsky@USSJC-ASOKOLSKY > ~/Projects/asokolsky.github.io | main ± > pyenv exec python -m pip --version
pip 24.1.2 from /Users/asokolsky/.pyenv/versions/3.12.2/lib/python3.12/site-packages/pip (python 3.12)
```
Install it:
```
pyenv exec python -m pip install pyperformance
```

System configuration does not work:
```
{% include_relative mbp2019-pyperf-config.txt %}
```

Run performance test:
```sh
pyperformance run -o t14g3win.json
```

### Latitude 7490 vs Thinkpad P52

```
{% include_relative latitude-vs-p52.txt %}
```

### Latitude 7490 vs Thinkpad T14 Gen 3

```
{% include_relative latitude-vs-t14g3win.txt %}
```

### Thinkpad P52 vs Thinkpad T14 Gen 3

```
{% include_relative p52-vs-t14g3win.txt %}
```
