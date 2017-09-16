	//#version 300 es 			
      
		
	precision mediump float;                            
	//in vec2 v_tex_coord;                            
	varying vec2 v_tex_coord;                            
      	uniform mediump int image_proc;				
	uniform mediump int uimage_width;				
	uniform sampler2D s_luma_texture;                        
	//layout (location=0) out vec4 out_color; 
	
	// Additive offset for BT656 YUV to RGB transform.	
	const vec3 offset = vec3(0, -0.5, -0.5);	
	// Temporary variable for YUV value	
	vec3 yuv;	
	// Temporary variable for RGB value	
	vec3 rgb;
	
	
      void main()                                         
	

      {                                                   
      
	vec4 luma_chroma;	       
	float xcoord;       
	float texture_width;       
	float texel_width; 
	const mat3 coeff = mat3(	
	    1.0,      1.0,     1.0,	
	    0.0,     -0.344,  1.722,	
	    1.402,   -0.714,   0);	
	      
	vec3 yuv;		       
	vec4 res;		       
	texture_width=float(uimage_width);	
	texel_width=1.0f/texture_width;
	xcoord = floor (v_tex_coord.x * texture_width);	
	luma_chroma = texture2D(s_luma_texture, v_tex_coord);	
	// just look up the brightness
	yuv.x = luma_chroma.r;//a;
	if (0.0 == mod(xcoord , 2.0)) {	// even
		yuv.y = luma_chroma.a;
		yuv.z = texture2D(s_luma_texture,vec2(v_tex_coord.x + texel_width, v_tex_coord.y)).a; 	    
	}
	else{	// odd
		yuv.z = luma_chroma.a;
		yuv.y = texture2D(s_luma_texture,vec2(v_tex_coord.x - texel_width, v_tex_coord.y)).a; 	    
	}	
	  
	yuv += offset;
	rgb = coeff * yuv;
	if(image_proc==2){
		rgb.r = yuv.x;
		rgb.g = yuv.x;
		rgb.b = yuv.x;
	}
	else if(image_proc==3){
		rgb.r = yuv.y+0.5;
		rgb.g = yuv.y+0.5;
		rgb.b = yuv.y+0.5;
	}
	else if(image_proc==4){
		rgb.r = yuv.z+0.5;
		rgb.g = yuv.z+0.5;
		rgb.b = yuv.z+0.5;
	}
	else if(image_proc==5){
		rgb.g = 0.0f;
		rgb.b = 0.0f;
	}
	else if(image_proc==6){
		rgb.r = 0.0f;
		rgb.b = 0.0f;
	}	
	else if(image_proc==7){
		rgb.r = 0.0f;
		rgb.g = 0.0f;
	}
	/*
	switch (image_proc)		
	{				
		case 0:
			break;
		case 2://y
			rgb.r = yuv.x;
			rgb.g = yuv.x;
			rgb.b = yuv.x;
		break;
		
		case 3://u
			rgb.r = yuv.y+0.5;
			rgb.g = yuv.y+0.5;
			rgb.b = yuv.y+0.5;
		break;
		
		case 4://v
			rgb.r = yuv.z+0.5;
			rgb.g = yuv.z+0.5;
			rgb.b = yuv.z+0.5;
		break;
		
		case 5://r
			rgb.g=0.0f;
			rgb.b=0.0f;
		break;
		case 6://g
			rgb.r=0.0f;
			rgb.b=0.0f;
		break;
		case 7://b
			rgb.r=0.0f;
			rgb.g=0.0f;
		break;
	}*/
	//out_color = vec4(rgb,1);
	gl_FragColor = vec4(rgb,1);
      }                                                   

 