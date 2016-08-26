
# UVC_MJPG_STREAMER

## A single binary executable that allows one to stream webcam frames via http

Provided top-level makefile is suitable for OpenWrt/Opkg environment.
If you want to build it on another architecture, just use src/makefile like this:
`make src/makefile`

Usage example `uvc_mjpg_streamer -i " -r 320x240" -o " -p 8080 -w /www/webcam`
Note leading spaces after quotes, as of now they are necessary.

## A more detailed list of input options:

mjpg-streamer input plugin: input_uvc
=====================================

This plugin provides JPEG data from V4L/V4L2 compatible webcams.

Usage
=====

    `mjpg_streamer -i ' [options]'`
    
```
---------------------------------------------------------------
Help for input plugin..: UVC webcam grabber
---------------------------------------------------------------
The following parameters can be passed to this plugin:

[-d | --device ].......: video device to open (your camera)
[-r | --resolution ]...: the resolution of the video device,
                         can be one of the following strings:
                         QSIF QCIF CGA QVGA CIF VGA 
                         SVGA XGA SXGA 
                         or a custom value like the following
                         example: 640x480
[-f | --fps ]..........: frames per second
                         (activates YUYV format, disables MJPEG)
[-m | --minimum_size ].: drop frames smaller then this limit, useful
                         if the webcam produces small-sized garbage frames
                         may happen under low light conditions
[-e | --every_frame ]..: drop all frames except numbered
[-n | --no_dynctrl ]...: do not initalize dynctrls of Linux-UVC driver
[-l | --led ]..........: switch the LED "on", "off", let it "blink" or leave
                         it up to the driver using the value "auto"
---------------------------------------------------------------

[-t | --tvnorm ] ......: set TV-Norm pal, ntsc or secam
---------------------------------------------------------------

Optional parameters (may not be supported by all cameras):

[-br ].................: Set image brightness (auto or integer)
[-co ].................: Set image contrast (integer)
[-sh ].................: Set image sharpness (integer)
[-sa ].................: Set image saturation (integer)
[-cb ].................: Set color balance (auto or integer)
[-wb ].................: Set white balance (auto or integer)
[-ex ].................: Set exposure (auto, shutter-priority, aperature-priority, or integer)
[-bk ].................: Set backlight compensation (integer)
[-rot ]................: Set image rotation (0-359)
[-hf ].................: Set horizontal flip (true/false)
[-vf ].................: Set vertical flip (true/false)
[-pl ].................: Set power line filter (disabled, 50hz, 60hz, auto)
[-gain ]...............: Set gain (auto or integer)
[-cagc ]...............: Set chroma gain control (auto or integer)
---------------------------------------------------------------
```

## A more detailed list of output options

mjpg-streamer output plugin: output_http
========================================

This plugin streams JPEG data from input plugins via HTTP.

Usage
=====

    `mjpg_streamer [input plugin options] -o ' [options]'`

```
---------------------------------------------------------------
The following parameters can be passed to this plugin:

[-w | --www ]...........: folder that contains webpages in 
                          flat hierarchy (no subfolders)
[-p | --port ]..........: TCP port for this HTTP server
[-c | --credentials ]...: ask for "username:password" on connect
[-n | --nocommands ]....: disable execution of commands
---------------------------------------------------------------
```

Browser/VLC
-----------

To view the stream use VLC or Firefox/Chrome and open the URL:

    http://127.0.0.1:8080/?action=stream

To do the same as the GET request above using NSURLSession in Objective-C, a POST request seems to work: 

    POST http://127.0.0.1:8080/stream 

To view a single JPEG just open this URL:

    http://127.0.0.1:8080/?action=snapshot

mplayer
-------

To play the HTTP M-JPEG stream with mplayer:

    # mplayer -fps 30 -demuxer lavf "http://127.0.0.1:8080/?action=stream&ignored.mjpg"

It might be necessary to configure mplayer to prefer IPv4 instead of IPv6:

    # vi ~./mplayer/config
    add or change the option: prefer-ipv4=yes

