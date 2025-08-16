# Use mise in Dockerfile

[Mise + Docker Cookbook](https://mise.jdx.dev/mise-cookbook/docker.html).

Dockerfile installing mise and more of the toolchain:

```
FROM ...
#
# Specify versions....
#
ENV TERRAFORM_VERSION='1.5.1'
ENV COSIGN_VERSION='2.5.3'
ENV MISE_VERSION='2025.8.9'
#
# Nothing to edit below
#
ENV MISE_DATA_DIR='/mise'
ENV MISE_CONFIG_DIR='/mise'
ENV MISE_CACHE_DIR='/mise/cache'
ENV MISE_INSTALL_PATH='/usr/local/bin/mise'
ENV PATH="/mise/shims:$PATH"
#
# necessary only for manual builds if you run into
# `mise WARN  GitHub rate limit exceeded.`
# ENV MISE_GITHUB_TOKEN='ghp_*****'
#
# Create mise config
#
COPY <<EOF /mise/mise.toml
[settings]
idiomatic_version_file_enable_tools = ["terraform"]

[tools]
cosign = "${COSIGN_VERSION}"
terraform = "${TERRAFORM_VERSION}"
EOF
#
# Install mise
#
RUN set -eux \
    && curl -fsSL https://mise.run | sh -s -- --yes \
    && mise --version | grep "${MISE_VERSION}"
#
# Install the toolchain components
#
RUN set -eux \
	&& mise install \
	&& cosign version | grep "v${COSIGN_VERSION}" \
	&& terraform --version | grep "v${TERRAFORM_VERSION}"
```
