	#version 300 es 			
      
	precision mediump float;                            
	in vec2 v_tex_coord;    
	uniform mediump int image2_proc;				
		
      	uniform sampler2D s_luma_texture;                        
	layout (location=0) out vec4 out_color;   
	
      void main()                                         
	

      {
	vec2 texelsize=vec2(1.0f/1440.0f,1.0f/720.0f);      
	vec4 rgba;
	rgba= texture2D(s_luma_texture, v_tex_coord);
	switch (image2_proc)		
	{				
		case 0:				
			vec4 tm1m1 = texture2D(s_luma_texture,v_tex_coord+vec2(-1,-1)*texelsize);
			vec4 tm10 =  texture2D(s_luma_texture,v_tex_coord+vec2(-1,0)*texelsize);
			vec4 tm1p1 = texture2D(s_luma_texture,v_tex_coord+vec2(-1,1)*texelsize);
			vec4 tp1m1 = texture2D(s_luma_texture,v_tex_coord+vec2(1,-1)*texelsize);
			vec4 tp10 =  texture2D(s_luma_texture,v_tex_coord+vec2(1,0)*texelsize);
			vec4 tp1p1 = texture2D(s_luma_texture,v_tex_coord+vec2(1,1)*texelsize);
			vec4 t0m1 =  texture2D(s_luma_texture,v_tex_coord+vec2(0,-1)*texelsize);
			vec4 t0p1 =  texture2D(s_luma_texture,v_tex_coord+vec2(0,-1)*texelsize);

			vec4 xdiff = -1.0*tm1m1 + -2.0*tm10 + -1.0*tm1p1 + 1.0*tp1m1 + 2.0*tp10 + 1.0*tp1p1;
			vec4 ydiff = -1.0*tm1m1 + -2.0*t0m1 + -1.0*tp1m1 + 1.0*tm1p1 + 2.0*t0p1 + 1.0*tp1p1;
			vec4 tot = sqrt(xdiff*xdiff+ydiff*ydiff);

			rgba = tot;
		break;
		
		
		case 5://r
			rgba.g=0.0f;
			rgba.b=0.0f;
		break;
		case 6://g
			rgba.r=0.0f;
			rgba.b=0.0f;
		break;
		case 7://b
			rgba.r=0.0f;
			rgba.g=0.0f;
		break;
	}
	out_color =rgba;
	
      }                                                   

 