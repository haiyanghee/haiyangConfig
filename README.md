# haiyangConfig
To fix chromium border, go to `Settings` -> `Use system title bar and borders`

To "enable" pdf scrolling with vimium, get PDF Viewer from chromium store.

Also add dash to /bin/sh i guess?

# Emoji coverage
install the following font packages from pacman (I don't recall which package actually fixes the problem but just install these there is no harm):
```
noto-fonts-emoji
```
Maybe add the rest, but you don't really need it..
```
ttf-font-awesome
ttf-inconsolata
ttf-symbola
unicode-emoji
```

# Disable mouse acceleration
Put this file in `/etc/X11/xorg.conf.d/50-mouse-acceleration.conf`:
```
Section "InputClass"
	Identifier "Logitech G403 Prodigy Gaming Mouse" #your mouse name
	MatchIsPointer "yes"
# set the following to 1 1 0 respectively to disable acceleration.
	#Option "AccelerationNumerator" "1"
	#Option "AccelerationDenominator" "1"
	#Option "AccelerationThreshold" "0"
	Option "AccelerationProfile" "-1"
	Option "AccelerationScheme" "none"
	Option "AccelSpeed" "-1"
EndSection

```
# Change trackpoint speed  (especially after disabling mouse acceleration)
Based on https://wayland.freedesktop.org/libinput/doc/latest/device-quirks.html#installing-temporary-local-device-quirks, we need to create `/etc/libinput/local-overrides.quirks` file. 

You can run `xinput` to see the available devices and their id. Then run `xinput -list-props id` and you can see which device node it is. In this example, the trackpoint is `/dev/input/event14`.

To see if any quirks are used, run `sudo libinput quirks list /dev/input/event14`. If nothing outputted, that means no quirks are used, which is often the case. To see the quirks libinput have tried, add `--verbose` argument, so run `sudo libinput quirks list --verbose /dev/input/event14`. Then you can see "Lenovo ... trackpoint" at `50-system-lenovo.quirks` (just example name here). And if you go to `/usr/share/libinput`, you can open `50-system-lenovo.quirks` to see the example config, but **be sure to change the `MatchName`**. 

For example, when I run `xinput` I see that my trackpad is named `ETPS/2 Elantech Touchpad`, and the config does support wildecard, so you can do `MatchName=*Elantech Touchpad`. You can also change the `AttrTrackpointMultiplier` to modify the trackpoint speed.

Here is my config:
```
[Lenovo T495s Trackpoint]
MatchName=*Elantech TrackPoint
MatchDMIModalias=dmi:*svnLENOVO:*:pvrThinkPadT495s:*
AttrTrackpointMultiplier=2.6
```

# AMDGPU
Put this file in `/etc/X11/xorg.conf.d/20-amdgpu.conf`:
```
Section "Device"
    Identifier  "AMD Graphics" 
    Driver      "amdgpu"
    Option      "Backlight"  "amdgpu_bl0"
EndSection

```
And maybe this file in `/usr/share/X11/xorg.conf.d/10-amdgpu.conf` (but this might be auto generated, I can't remember):
```
Section "OutputClass"
	Identifier "AMDgpu"
	MatchDriver "amdgpu"
	Driver "amdgpu"
EndSection
```
# Libinput conf?
Maybe put this file in `/usr/share/X11/xorg.conf.d/40-libinput.conf` (might be auto generated):
```
# Match on all types of devices but joysticks
#
# If you want to configure your devices, do not copy this file.
# Instead, use a config snippet that contains something like this:
#
# Section "InputClass"
#   Identifier "something or other"
#   MatchDriver "libinput"
#
#   MatchIsTouchpad "on"
#   ... other Match directives ...
#   Option "someoption" "value"
# EndSection
#
# This applies the option any libinput device also matched by the other
# directives. See the xorg.conf(5) man page for more info on
# matching devices.

Section "InputClass"
        Identifier "libinput pointer catchall"
        MatchIsPointer "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput keyboard catchall"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput touchscreen catchall"
        MatchIsTouchscreen "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

Section "InputClass"
        Identifier "libinput tablet catchall"
        MatchIsTablet "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
EndSection

```
