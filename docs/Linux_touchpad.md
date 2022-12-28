## Natural two finger scroll and two finger tap to rightclick
### List input devices to identify the touchpad ID
```
$ xinput
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ Elan Touchpad                           	id=10	[slave  pointer  (2)]
⎜   ↳ Elan TrackPoint                         	id=11	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=8	[slave  keyboard (3)]
    ↳ Integrated Camera: Integrated C         	id=9	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=12	[slave  keyboard (3)]
    ↳ ThinkPad Extra Buttons                  	id=13	[slave  keyboard (3)]
```
Notice the touchpad having the **ID 10**


### List touchpad properties
```sh
$ xinput list-props 10
Device 'Elan Touchpad':
	Device Enabled (189):	1
	Coordinate Transformation Matrix (191):	1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
	libinput Tapping Enabled (325):	0
	libinput Tapping Enabled Default (326):	0
	libinput Tapping Drag Enabled (327):	1
	libinput Tapping Drag Enabled Default (328):	1
	libinput Tapping Drag Lock Enabled (329):	0
	libinput Tapping Drag Lock Enabled Default (330):	0
	libinput Tapping Button Mapping Enabled (331):	1, 0
	libinput Tapping Button Mapping Default (332):	1, 0
	libinput Natural Scrolling Enabled (333):	0
	libinput Natural Scrolling Enabled Default (334):	0
	libinput Disable While Typing Enabled (335):	1
	libinput Disable While Typing Enabled Default (336):	1
	libinput Scroll Methods Available (337):	1, 1, 0
	libinput Scroll Method Enabled (338):	1, 0, 0
	libinput Scroll Method Enabled Default (339):	1, 0, 0
	libinput Click Methods Available (340):	1, 1
	libinput Click Method Enabled (341):	1, 0
	libinput Click Method Enabled Default (342):	1, 0
	libinput Middle Emulation Enabled (343):	0
	libinput Middle Emulation Enabled Default (344):	0
	libinput Accel Speed (345):	0.000000
	libinput Accel Speed Default (346):	0.000000
	libinput Accel Profiles Available (347):	1, 1
	libinput Accel Profile Enabled (348):	1, 0
	libinput Accel Profile Enabled Default (349):	1, 0
	libinput Left Handed Enabled (350):	0
	libinput Left Handed Enabled Default (351):	0
	libinput Send Events Modes Available (310):	1, 1
	libinput Send Events Mode Enabled (311):	0, 0
	libinput Send Events Mode Enabled Default (312):	0, 0
	Device Node (313):	"/dev/input/event4"
	Device Product ID (314):	1267, 32
	libinput Drag Lock Buttons (352):	<no items>
	libinput Horizontal Scroll Enabled (353):	1
	libinput Scrolling Pixel Distance (354):	15
	libinput Scrolling Pixel Distance Default (355):	15
	libinput High Resolution Wheel Scroll Enabled (356):	1
```
* The Tapping enabled property has the **ID 325**
* The Natural scroll property has the **ID 333**


### Enable tapping
```
$ xinput set-prop 10 325 1
```
### Enable natural scrolling
```
$ xinput set-prop 10 333 1
```