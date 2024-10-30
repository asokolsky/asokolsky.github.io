# AWS Credentials

https://boto3.amazonaws.com/v1/documentation/api/latest/guide/credentials.html

CLI:
```
sudoer@ds-worker-steelix-15:~$ aws sts get-caller-identity
{
    "UserId": "AROAJD7XRIBKDULHHY3MI:i-0fc68b5a34fc0a438",
    "Account": "374926383693",
    "Arn": "arn:aws:sts::374926383693:assumed-role/ds_worker_steelix/i-0fc68b5a34fc0a438"
}
```

python:

```python
import boto3

client = boto3.client('sts')
response = client.get_caller_identity()
print(response)
```

Using it:
```
ubuntu@ds-worker-steelix-15:~/pytest$ python3 -m venv .venv
ubuntu@ds-worker-steelix-15:~/pytest$ cat requirements.txt
boto3
ubuntu@ds-worker-steelix-15:~/pytest$ pip3 install -r requirements.txt
ubuntu@ds-worker-steelix-15:~/pytest$ source .venv/bin/activate
(.venv) ubuntu@ds-worker-steelix-15:~/pytest$ python3 test.py
{
  "UserId": "AROAJD7XRIBKDULHHY3MI:i-0fc68b5a34fc0a438",
  "Account": "374926383693",
  "Arn": "arn:aws:sts::374926383693:assumed-role/role-name/i-0fc68b5a34fc0a438",
  ...
}
```

## Assume Role

```python

  arn = 'arn:aws:iam::DESTINATION-ACCOUNT-ID:role/DESTINATION-ROLENAME'
  sts_client = boto3.client('sts')

  response = sts_client.get_caller_identity()
  print(json.dumps(response, indent=2))

  assumed_role_object = sts_client.assume_role(
      RoleArn=arn, RoleSessionName="AssumeRoleSession1" )
  credentials = assumed_role_object['Credentials']

  # Initialize MWAA client and request a web login token
  mwaa = boto3.client(
      'mwaa',
      aws_access_key_id=credentials['AccessKeyId'],
      aws_secret_access_key=credentials['SecretAccessKey'],
      aws_session_token=credentials['SessionToken'])
```

In order for the above to work:

1. The current account/role should have an IAM policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["sts:AssumeRole"],
      "Resource": [
        "arn:aws:iam::DESTINATION-ACCOUNT-ID:role/DESTINATION-ROLENAME"
      ]
    }
  ]
}
```

2. Destination account should have a trust policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::SOURCE-ACCOUNT-ID:user/SOURCE-USERNAME"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```
