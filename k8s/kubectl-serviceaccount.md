# kubectl ServiceAccount

[kubectl_create_serviceaccount](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_serviceaccount/)

Along with the service account, automatically created are:

* a token to be used for communication with the API server
* a secret, storing the token and linked to the service account

Create a service acount:
```sh
k create serviceaccount dashboard-sa
k create token dashboard-sa
```

The latter creates:
eyJhbGciOiJSUzI1NiIsImtpZCI6Ind6OTh4R3czNnVuSHdDUGlwX19XVHF0ZlpoU2FSV2I0MFhpY2NGRXZJX00ifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiLCJrM3MiXSwiZXhwIjoxNzE1NjQwMDMzLCJpYXQiOjE3MTU2MzY0MzMsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJkZWZhdWx0Iiwic2VydmljZWFjY291bnQiOnsibmFtZSI6ImRhc2hib2FyZC1zYSIsInVpZCI6IjM5MjVmODhjLTYwYTUtNGMxMy05OWUwLWQ2NjkwOWM3ZWQzOSJ9fSwibmJmIjoxNzE1NjM2NDMzLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.B_baE3N7GMgJY3GOQa0zl18s_VtYoB-wR17yjad9LYID3agZ2oqzdOR-bQeU4gepSvs-wuwWSCQ3IBMsmogebfWaCx5iUeWquUeu18StOXPvKJJRlpWOw0c-FhuTC3JUNhdGewcEETWv9SuATbmoNK7Gkx1QuLc1Mwj1IxTEHlTne-YBGJiZ-C88JVvlPgB4RqJXcpnfXLsdeIc91wfFqXrAhNdlExhS6wD5SJv_Ok5tpzyHfDQAgtwaPsqcyMhVjtd1fgwR-uZlU3ojL8a3dnX8fL4-q0SY0xL9qWNVL01InWyMc6m9U0xOOgkWux0C8zC_CXsIsDEyaYbqQ9hisA


To describe a newly created service acount:
```sh
k describe serviceaccount dashboard-sa
```

To retrieve the value of the associated token:
```sh
k describe secret dashboard-sa-token-kbbdm
```

Use the token to authenticate to the API endpoint:
```sh
curl https://192.168.56.70:6443/api -insecure \
    --header "Authorization: Bearer eyXXXX..."
```

To simplify use of the token, one can mount the service token secret as a
volume, so that the app can easily read it.

Each NS has its own service account, e.g. NS `default` has `default-sa`.

Each pod has a mount to `/var/run/secrets/kubernetes.io/serviceaccount` to the
service account token.

[Decode the token using CLI](https://gist.github.com/angelo-v/e0208a18d455e2e6ea3c40ad637aac53).