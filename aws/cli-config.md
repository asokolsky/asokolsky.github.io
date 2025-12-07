# AWS Config

[AWS Config](https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html)


Query by resource type and id:
```sh
aws configservice get-resource-config-history --limit 3 --output json \
    --resource-type AWS::EC2::SecurityGroup --resource-id sg-123456789012 \
    --query 'configurationItems[*].{CaptureTime:configurationItemCaptureTime,Status:configurationItemStatus}' \
    | python3 -c "import sys, json; from datetime import datetime; items = json.load(sys.stdin); [print(f\"{item['Status']:20} {datetime.fromtimestamp(float(item['CaptureTime'])).strftime('%Y-%m-%d %H:%M:%S')}\") for item in items]"
```
