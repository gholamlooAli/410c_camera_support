# 410c_camera_support
This github is forked from D3 Engineering website to evaluate the camera module for dragon board 410c.

To run the application go to opengles_capture folder and run the following command:

# ./capture -d /dev/video0 -s /dev/v4l-subdev10 for direct dump to memory mode

# ./capture -d /dev/video3 -s /dev/v4l-subdev10 for NV12 format mode

the following are the accepted keyword :
	
-h to print help

-e 0 for EGLImage zero memory copy or -e 1 for loading buffer to gpu memory

-0 to define the desired display window width

-1 to define the desired display window height

-4 !=1 first copy image to frame buffer texture as rgb then render to display  -4=1 for copy to display directl

while application is running press the following key for image processing:
	
press y to show only the y portion (luminance)

press u to show only the u portion (cb-chrominance)

press v to show only the v portion (cr-chrominance)

press r to show only the red color

press g to show only the green color

press b to show only the blue color

press c to show all colors

press s to apply soble filter for edge detection

press q to quit	