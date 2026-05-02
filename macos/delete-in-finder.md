# Delete in Finder

In Karabiner > Settings > Complex Modifications > Add your own rule:

```json
{
    "description":"Delete Moves to Trash",
    "manipulators":[
        {
            "conditions":[
                {
                    "bundle_identifiers":[
                        "^com\\.apple\\.finder"
                    ],
                    "type":"frontmost_application_if"
                }
            ],
            "from":{
                "key_code":"delete_forward",
                "modifiers":{
                    "optional":[
                        "any"
                    ]
                }
            },
            "to":[
                {
                    "key_code":"delete_or_backspace",
                    "modifiers":[
                        "left_command"
                    ]
                }
            ],
            "type":"basic"
        }
    ]
}
```
