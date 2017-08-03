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
		//vec4 res[3];
		
		texel_width=1.0f/float(uimage_width);
		texel_height=1.0f/float(uimage_height);
		vec2 texelsize=vec2(texel_width,texel_height);    
		vec2 texelsize2=vec2(texel_width*2.0f,texel_height*2.0f);    
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
		//float yy[9],uu[9],vv[9],rr[9],gg[9],bb[9];
		yuv += offset;
		rgb = coeff * yuv;
		switch (image_proc)		
		{	
			case 0:
			break;
			/*
			case 8:	
				
				for(int i=0; i<3; i++){
					for(int j=0; j<3; j++){
						int nn=i*3 + j;;	
						uu[nn] = float(texture2D(s_chroma_texture, v_tex_coord+ vec2(i-1,j-1)*texelsize).x);
						vv[nn] = float(texture2D(s_chroma_texture, v_tex_coord+ vec2(i-1,j-1)*texelsize).w);
						yy[nn] = float(texture2D(s_luma_texture  , v_tex_coord+ vec2(i-1,j-1)*texelsize ).x);
						uu[nn]-=0.5f;
						vv[nn]-=0.5f;
						yy[nn] = (yy[nn]- 0.0625f) * 1.1643f;
						
						rr[nn] = yy[nn]  + 1.402f  * vv[nn];
						gg[nn] = yy[nn]  - 0.3441f * uu[nn] - 0.7141f * vv[nn];
						bb[nn] = yy[nn]  + 1.772f  * uu[nn];
					}
				}
				
				vec3 tm1m1 = vec3(rr[0],bb[0],gg[0]);
				vec3 tm10 =  vec3(rr[1],bb[1],gg[1]);
				vec3 tm1p1 = vec3(rr[2],bb[2],gg[2]);
				vec3 tp1m1 = vec3(rr[6],bb[6],gg[6]);
				vec3 tp10 =  vec3(rr[7],bb[7],gg[7]);
				vec3 tp1p1 = vec3(rr[8],bb[8],gg[8]);
				vec3 t0m1 =  vec3(rr[3],bb[3],gg[3]);
				vec3 t0p1 =  vec3(rr[5],bb[5],gg[5]);

				vec3 xdiff = -1.0*tm1m1 + -2.0*tm10 + -1.0*tm1p1 + 1.0*tp1m1 + 2.0*tp10 + 1.0*tp1p1;
				vec3 ydiff = -1.0*tm1m1 + -2.0*t0m1 + -1.0*tp1m1 + 1.0*tm1p1 + 2.0*t0p1 + 1.0*tp1p1;
				tot = sqrt(xdiff*xdiff+ydiff*ydiff);

				//rgb.r = tot.r;
			break;
			*/
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
		//if(image_proc==8)
			
		out_color = vec4(rgb,1);
	}


 