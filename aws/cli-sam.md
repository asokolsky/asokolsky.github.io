# AWS Serverless Application Model (SAM) CLI

https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html


## Installation

1. Download the package [aws-sam-cli-macos-arm64.pkg](https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-macos-arm64.pkg)
2. Modify and run the installation script:
```
sudo installer -pkg path-to-pkg-installer/name-of-pkg-installer -target /
```
3. Verify:
```
> which sam
/usr/local/bin/sam
```
Compare to aws cli:
```
> which aws
/opt/homebrew/bin/aws
```
Version:
```
> sam --version
SAM CLI, version 1.145.2
```
