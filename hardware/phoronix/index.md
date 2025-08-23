# phoronix

[repo](https://github.com/phoronix-test-suite/phoronix-test-suite)

## Installation

Download and install the latest release from github:

```sh
curl -vL  https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v10.8.4/phoronix-test-suite_10.8.4_all.deb \
    -o phoronix-test-suite_10.8.4_all.deb
sudo apt install ./phoronix-test-suite_10.8.4_all.deb
```

Install pre-requisites for the specific benchmark:
```sh
phoronix-test-suite install build-linux-kernel
sudo apt install libelf-dev
```

## Benchmarking

```sh
phoronix-test-suite benchmark build-linux-kernel
```

* result file: `t14g3-build-linux-kernel`
* unique ID: 20250823

## View Results

```sh
phoronix-test-suite show-result t14g3-build-linux-kernel
```

## Upload Results

```sh
phoronix-test-suite upload t14g3-build-linux-kernel
```

## Summary

### build-linux-kernel

* [exi](https://openbenchmarking.org/result/2508236-NE-EXIBUILDL69) - 148.32 sec
* [t14g3](https://openbenchmarking.org/result/2508239-NE-T14G3BUIL19) - 276.27 sec
* [p52](https://openbenchmarking.org/result/2508230-NE-P52BUILDL93) - 309.96 sec
