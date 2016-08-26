CC=gcc

all:
	$(CC) utils.c dynctrl.c jpeg_utils.c v4l2uvc.c input_uvc.c httpd.c output_http.c mjpg_main.c -o uvc_mjpg_streamer -ljpeg -lpthread

