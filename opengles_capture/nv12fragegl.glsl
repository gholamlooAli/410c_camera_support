     #version 300 es	
	//FRAGMENT_SHADER	
	precision mediump float;	
	// position lookup used for both textures	
	in vec2 v_tex_coord;	
	// Output of the shader, RGB color per position in surface	
	layout(location = 0) out vec4 out_color;	
	// Additive offset for BT656 YUV to RGB transform.	
	const vec3 offset = vec3(0, -0.5, -0.5);	
	// Column order vector gain for BT656 YUV to RGB transform	
	
	const mat3 coeff = mat3(	
	    1.0,      1.0,     1.0,	
	    0.0,     -0.344,  1.722,	
	    1.402,   -0.714,   0);	
	// Temporary variable for YUV value	
	vec3 yuv;	
	// Temporary variable for RGB value	
	vec3 rgb;	
	// Two used textures to hold the YUV420 Semi semi-planar data
	// The luma texture holds three copies of the Y value in fields r,g,b or x,y,z, and 1.0 for w
	uniform sampler2D s_luma_texture;
	// The chroma texture holds three copies of the CR value in fields or x,y,z, and CB in w
	uniform sampler2D s_chroma_texture;
	void main()
	{
		float xcoord,ycoord;       
		float texture_width;       
		float texel_width;       
		vec3 yuv;		       
		vec4 res;		       
		texture_width=float(1280);	
		texel_width=1.0/texture_width;
		xcoord = floor (v_tex_coord.x * 1280.0f);//texture_width);	
		//ycoord = floor (v_tex_coord.y * 960.0f);	
		int xcor=int (xcoord);
		//res = texture2D(s_luma_texture, v_tex_coord);
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
		// Lookup the texture at the  position in the render window.
	    // Take the two semi-planar textures assemble into single YUV pixel.
	    //if (0.0 != mod(ycoord , 2.0)) 	// even
		//yuv.x = texture2D(s_luma_texture, v_tex_coord).x;
	    //else
		// yuv.x=1.0f;   
	    yuv.yz = texture2D(s_chroma_texture, v_tex_coord).xw;
	    if(xcoord==ycoord)
		yuv.x=1.0f;
	
	    // Then convert to YUV to RGB using offset and gain.
	    yuv += offset;
	    //yuv.y=0.0f;
	    //yuv.z=0.0f;
	    rgb = coeff * yuv;
	    out_color = vec4(rgb,1);
	}


 