# haiyangConfig
To fix chromium border, go to `Settings` -> `Use system title bar and borders`

To "enable" pdf scrolling with vimium, get PDF Viewer from chromium store.

Also add dash to /bin/sh I guess?

# Java LSP
Install `jdtls` first. If you use archlinux, then jdtls will be installed in `/usr/share/java/jdtls`.
Then create the following script in a directory like `/usr/local/bin/jdtls`:
```
#!/usr/bin/env sh

# copy the configuration folder to tmp to be writable
tmp_dir="$(mktemp -d /tmp/jdtls.XXXXX)"
cp -R /usr/share/java/jdtls/config_linux "${tmp_dir}"
# and ensure that it is removed on exit
trap "{ rm -rf ${tmp_dir}; }" EXIT

server=/usr/share/java/jdtls #or whereever jdtls is installed at

java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -noverify \
    -Xms1G \
    -jar $server/plugins/org.eclipse.equinox.launcher_1.*.jar \
    -configuration ${tmp_dir}/config_linux/ \
    "$@"
```
Then put this in vimrc:
```
let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
    \ }

```
Then this should work!

# Language client serverCommands autocmd/autogroup
If you want to source different .vim configs for different file types, you need to add `BufReadPre`, like:

```
au  BufReadPre,BufRead,BufEnter *.cpp source ~/.config/nvim/init_cpp.vim
```
This way `g:LanguageClient_serverCommands` will get sourced in before it starts so that the language client actually runs.

# Wine audio laggy / glitching
Just try to tune it using the options here: https://forums.linuxmint.com/viewtopic.php?t=44862

Also according to the [wiki](https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Setting_the_default_fragment_number_and_buffer_size_in_PulseAudio), you also should add `tsched=0` in the following in `/etc/pulse/default.pa`:
```
load-module module-udev-detect tsched=0
```

# How to see how much memory a process is taking
You can get `ps_mem` (the [github page](https://github.com/pixelb/ps_mem)) and see example usages.

For example, you can do `sudo ps_mem -p $(pgrep -d, chromium)` to see how much memory chromium is taking

# Open links in Zathura issue
Maybe you have encountered a issue where you want to open links in `zathura` but `xdg-open` just fails you, and at the end you will get "no method available for opening" some link. 

Firstly, you should set a `BROWSER` variable in your `~/.bashrc`. I use chromium so I just did `export BROWSER="chromium"`. Then this is not enough for some reason (you will know it if you run `zathura` again, at least for me it didn't work). You should also add the line `set sandbox none` in your `zathurarc`, usually located at `~/.config/zathura/zathurarc`.

It might also be good to use `xdg-setting` to set the default web-browser like `xdg-settings set default-web-browser chromium.desktop`, as mentioned in the [wiki](https://wiki.archlinux.org/index.php/Xdg-utils#xdg-open)

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
# Detecting Elantech trackpoint and touchpad
Append the following kernel parameters to `/etc/default/grub`, at `GRUB_CMDLINE_LINUX_DEFAULT`:
```
i8042.nomux=1 i8042.reset
```
So an example parameter will look something like
```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet i8042.nomux=1 i8042.reset"
```
This should detect it... When you run `dmesg` you should be able to see that libinput recognizes the trackpoint and touchpad from `/devices/platform/i8042/...`

For example:
```
$ dmesg | grep -i trackpoint
[    2.522591] input: ETPS/2 Elantech TrackPoint as /devices/platform/i8042/serio1/input/input16
$ dmesg | grep -i touchpad
[    2.540001] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input8
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
