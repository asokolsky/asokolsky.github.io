# Checks When Buying a used MacOS device

## Hardware diagnostics

From [102550](https://support.apple.com/en-us/102550):

* shut it down

Apple silicon:

* Press and hold the power button.
* As you hold the power button, your Mac turns on and loads startup options. When you see Options, release the power button.
* Press and hold Command (⌘)-D until your Mac restarts.

If you see one or more reference codes and need more explanation, refer to the list of [Apple Diagnostics reference codes](https://support.apple.com/en-us/102334).

## Ensure iCloud Activation Lock is disabled

If Activation Lock is enabled, ask the seller to go to:

System Settings > Apple ID > iCloud

click Show More Apps, and turn off `Find My Mac`. Then check Activation Lock status again.

## Check if the MacBook is an "Enrolled" device

```sh
profiles status -type enrollment
```

If either the "Enrolled via DEP" or "MDM Enrollment" are "Yes", then don't purchase the MacBook.

Note: the above FAILED to identify the enrolled device for me.  During factory reset the laptop owner was displayed.  Hence, go for factory reset ASAP.

## Was Screen Replaced?

In Settings look for `True Tone`.  If it is not there - the screen has been replaced.

## Battery

In settings: `Battery Condition`

## Coverage

Copy the serial number from Settings app -> General -> About,  paste it [here](https://checkcoverage.apple.com).

## Factory Reset

* Apple menu > System Settings (or System Preferences).
* General > Transfer or Reset > Erase All Content and Settings
* Follow Prompts: Enter your administrator password, follow the on-screen instructions to sign out of Apple ID/Find My, and confirm.

* Restart: The Mac will restart, showing a black screen or progress bar.
