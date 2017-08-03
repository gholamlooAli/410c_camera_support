     #version 300 es	
	precision mediump float;	
	in vec2 v_tex_coord;	
	layout(location = 0) out vec4 out_color;	
	const vec3 offset = vec3(0, -0.5, -0.5);	
	
	const mat3 coeff = mat3(	
	    1.0,      1.0,     1.0,	
	    0.0,     -0.344,  1.722,	
	    1.402,   -0.714,   0);	
	vec3 yuv;	
	vec3 rgb;
	uniform mediump int image_proc;				
	uniform mediump int uimage_width;				
	uniform mediump int uimage_height;					
      	
	uniform sampler2D s_luma_texture;
	uniform sampler2D s_chroma_texture;
	void main()
	{
		float xcoord,ycoord;       
		float texel_width, texel_height;       
		vec3 yuv;		       
		vec4 res;
		
		texel_width=1.0f/float(uimage_width);
		texel_height=1.0f/float(uimage_height);
		vec2 texelsize=vec2(texel_width,texel_height);    
		xcoord = floor (v_tex_coord.x * float(uimage_width));
		int xcor=int (xcoord);
		int remi=xcor%4;
		if (0 == remi) {	// this is to prevent texture bleeding (tex. coordinate offset)
			yuv.x = texture2D(s_luma_texture,vec2( v_tex_coord.x-texel_width,v_tex_coord.y)).a;
		}
		if (1 == remi) {	// even
			yuv.x = texture2D(s_luma_texture, v_tex_coord).b;
		}
		if (2 == remi) {	// even
			yuv.x = texture2D(s_luma_texture, v_tex_coord).g;
		}
		if (3 == remi) {	// even
			yuv.x = texture2D(s_luma_texture, v_tex_coord).r;
		}
		yuv.yz = texture2D(s_chroma_texture, v_tex_coord).xw;
		
		yuv += offset;
		rgb = coeff * yuv;
		switch (image_proc)		
		{	
			case 0:
			break;
			
			case 8:			
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

				//rgba = tot;
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
		}
		
		out_color = vec4(rgb,1);
	}


 