///@desc

//Pulsing radius for demo
var _radius = cos(get_timer()/500000)*0.5+0.5;
//Control with mouse when pressed
if mouse_check_button(mb_left) _radius = clamp(1-mouse_x/room_width,0,1);

//Draw tiled background with blurring
gpu_set_tex_repeat(true);
mipblur_set_sprite(32*_radius);
draw_sprite_tiled(spr_tile,0,0,0);
mipblur_reset();

//Draw books, each with their own blur factor
for(var i = 0; i<=1;i+=.2)
{
	mipblur_set_sprite(32*sqr(i-_radius));
	draw_sprite(sprite_index,-1,x-768*(i-0.5),y);
}
mipblur_reset();