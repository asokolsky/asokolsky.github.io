# kubectl Installation

[Install](https://kubernetes.io/docs/tasks/tools/#kubectl) the `kubectl` cli to
interact with the Kubernetes API:

```sh
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
and then:
```sh
sudo apt-get update
sudo apt-get install -y kubectl
```

Set up autocompletion in bash:
```sh
echo "source <(kubectl completion bash)" >> ~/.bashrc
```
Alternatively in zsh:
```sh
echo "source <(kubectl completion zsh)" >> ~/.zshrc
```
