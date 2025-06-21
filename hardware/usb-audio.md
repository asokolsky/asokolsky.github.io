# USB Audio Device in Linux

## Using pulse audio

Start with `pactl` - this will list default sink and source.
```sh
pactl info
```

Then, for outputs:
```sh
pacmd list-sinks
```

For inputs:
```sh
pacmd list-sources
```

## Testing in Browser

Point your browser to https://mictests.com/
