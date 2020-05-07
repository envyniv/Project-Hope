///move_state
func_Ginput();
spd = 5

if (key_run) {
state = state_run;
alarm[0] = room_speed/5
} else { 
    if (key_attack && canattack == true) {
    state = state_nrmlAtk;
    image_index = 0;
    } else { 
    if (key_dodge && canattack == true) {
    state = state_dodge;
    alarm[1] = room_speed/8
    } 
    }
}

//get axis
var xaxis = (right - left);
var yaxis = (down - up);

//get direction
 dir = point_direction(0, 0, xaxis, yaxis);

//get the length
if (xaxis == 0 and yaxis == 0) {
    len = 0;
    } else {
    len = spd;
}

//h and v speeds
hspd = lengthdir_x(len, dir);
vspd = lengthdir_y(len, dir);

//Move
if (!place_meeting(x+hspd,y,obj_wall)) {
x += hspd
}
if (!place_meeting(x,y+vspd,obj_wall)) {
y += vspd
}
//Sprite manager
//image_speed = sign(len)*.2;
//if (len == 0) image_index = 0;

//Down and Up
//if (vspd > 0) {
//    sprite_index = playerdown
//    } else if (vspd < 0) {
//        sprite_index = playerup
//    }
    
//Right and Left
//if (hspd > 0) {
//    sprite_index = playerright
//    } else if (hspd < 0) {
//        sprite_index = playerleft
//    }
    
//Diagonal (Left and Up) (Up and Right)
//if (hspd < 0 and vspd < 0) {
//    sprite_index = playerul
//    } else if (hspd > 0 and vspd < 0) {
//        sprite_index = playerur
//    }
    
//Diagonal (Right and Down) (Down and Left)
//if (hspd > 0 and vspd > 0) {
//    sprite_index = playerdr
//    } else if (hspd < 0 and vspd > 0) {
//        sprite_index = playerdl
//    }
