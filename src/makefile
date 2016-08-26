
PROFILE = -O2 -s
CFLAGS = $(PROFILE)
LDFLAGS = -ljpeg -lpthread

all: main

# build it
main:
	$(CC) $(CFLAGS) utils.c dynctrl.c jpeg_utils.c v4l2uvc.c input_uvc.c httpd.c output_http.c mjpg_main.c $(LDFLAGS) -o uvc_mjpg_streamer

# clean it
clean:
	rm uvc_mjpg_streamer

