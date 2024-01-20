

/**
 * Enables linear texture filtering and mipmapping
 * 
 */
function mipblur_init()
{
	gpu_set_tex_filter(true);
	gpu_set_tex_mip_enable(true);

	global.u_mipblur_texel = shader_get_uniform(shd_mipblur,"u_texel");
	global.u_mipblur_radius = shader_get_uniform(shd_mipblur,"u_radius");
}
function mipblur_set_texture(radius,tex)
{
	var _tw = texture_get_texel_width(tex);
	var _th = texture_get_texel_height(tex);
	
	shader_set(shd_mipblur);
	shader_set_uniform_f(global.u_mipblur_texel, _tw, _th);
	shader_set_uniform_f(global.u_mipblur_radius, radius);
}
function mipblur_set_sprite(radius,sprite=sprite_index,index=image_index)
{
	var _tex = sprite_get_texture(sprite,index);
	
	mipblur_set_texture(radius,_tex);
}

function mipblur_reset()
{
	shader_reset();
}