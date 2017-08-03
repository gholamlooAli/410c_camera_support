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
	    yuv.x = texture2D(s_luma_texture, v_tex_coord).x;
	    yuv.yz = texture2D(s_chroma_texture, v_tex_coord).xw;
	    yuv += offset;
	    rgb = coeff * yuv;
	    out_color = vec4(rgb,1);
	}


 