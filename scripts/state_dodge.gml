//dodge_state
len = spd*4;

//h and v speeds
hspd = lengthdir_x(len, dir);
vspd = lengthdir_y(len, dir);

//Move
x += hspd
y += vspd

//dodge fx
dodge = instance_create(x,y,obj_speed_fx)
dodge.sprite_index = sprite_index;
dodge.image_index = image_index;

if (nodir && key_dodge) {
switch (sprite_index) {
    case playerup:
         //dash up
         break;
    case playerdown:
         //dash down
         break;
    case playerleft:
         //dash left
         break;
    case playerright:
         //dash right
         break; 
    case playerdr:
         // dash down-right
         break;
    case playerdl:
         // dash down-left
         break;
    case playerur:
         // dash up-right
         break;
    case playerul:
         // dash up-left
         break;
}
}

