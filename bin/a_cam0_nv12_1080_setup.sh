#!/bin/bash
set +x
# Connect CSI0 to ISP0 output
#sudo media-ctl -d /dev/media1 -l '"msm_csiphy0":1->"msm_csid0":0[1],"msm_csid0":1->"msm_ispif0":0[1],"msm_ispif0":1->"msm_vfe0_rdi0":0[1]'
 sudo media-ctl -d /dev/media1 -l '"msm_csiphy0":1->"msm_csid0":0[1],"msm_csid0":1->"msm_ispif0":0[1],"msm_ispif0":1->"msm_vfe0_pix":0[1]'
# Set resolution to 1920x1080
#sudo media-ctl -d /dev/media1 -V '"ov5640 1-0078":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_csiphy0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_csid0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_ispif0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_vfe0_pix":0[fmt:YUYV8_1_5X8/1920x1080 field:none]'
#sudo media-ctl -d /dev/media1 -V '"ov5645 1-0076":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_csiphy0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_csid0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_ispif0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_vfe0_pix":0[fmt:YUYV8_1_5X8/1920x1080 field:none]'

#sudo media-ctl -d /dev/media1 -V '"ov5645 1-0076":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_csiphy0":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_csid0":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_ispif0":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_vfe0_pix":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_vfe0_pix":1[fmt:UYVY8_1_5X8/1280x960 field:none]'


#sudo media-ctl -d /dev/media1 -V '"ov5645 1-0076":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_csiphy0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_csid0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_ispif0":0[fmt:UYVY8_2X8/1920x1080 field:none],"msm_vfe0_rdi0":0[fmt:UYVY8_2X8/1920x1080 field:none]'
sudo media-ctl -d /dev/media1 -V '"ov5645 1-0076":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_csiphy0":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_csid0":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_ispif0":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_vfe0_pix":0[fmt:UYVY8_2X8/1280x960 field:none],"msm_vfe0_pix":1[fmt:UYVY8_1_5X8/1280x960 field:none]'