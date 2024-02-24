# TrueNAS Scale Customization

[truenas-core](truenas-core.html)

## Enable apt for package management

```sh
sudo chmod a+x /usr/bin/apt*
sudo chmod a+x /usr/bin/dpkg
```

Before you install new packages, do:

```sh
sudo apt update
```

Then install packages as usual:
```sh
sudo apt install emacs-nox
```

## Drive Spin Down

https://github.com/ngandrass/truenas-spindown-timer


## VM Setup

* [video](https://www.youtube.com/watch?v=R7BXEuKjJ0k)
* [post](https://forum.level1techs.com/t/truenas-scale-ultimate-home-setup-incl-tailscale/186444)

## Running Apps (k3s)

* Set up [TrueCharts app catalog](true-charts.html)
