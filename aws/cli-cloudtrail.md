# Auto CloudTrail CLI

```sh
aws cloudtrail describe-trails --include-shadow-trails
```

## Event Search

Note MacOS flavor of the date utility:
```sh
aws cloudtrail lookup-events \
  --lookup-attributes AttributeKey=ResourceName,AttributeValue=sg-1234567890 \
  --start-time "$(date -v -10M -u +%Y-%m-%dT%H:%M:%SZ)" \
  --end-time   "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --max-results 20
```
