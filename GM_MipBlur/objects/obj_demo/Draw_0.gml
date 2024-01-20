///@desc

var _radius = cos(get_timer()/500000)*0.5+0.5;
if mouse_check_button(mb_left) _radius = clamp(1-mouse_x/room_width,0,1);

gpu_set_tex_repeat(true);
mipblur_set_sprite(32*_radius);
draw_sprite_tiled(spr_tile,0,0,0);
mipblur_reset();

for(var i = 0; i<=1;i+=.2)
{
	mipblur_set_sprite(32*sqr(i-_radius));
	draw_sprite(sprite_index,-1,x-768*(i-0.5),y);
}
mipblur_reset();