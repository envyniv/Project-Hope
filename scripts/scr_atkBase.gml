//general script for attacking functions
//sprites
image_speed = .5;
switch (sprite_index) {
    case playerdown:
        sprite_index = platkdown
        break;
        
    case playerleft:
        sprite_index = platkleft
        break;

    case playerright:
        sprite_index = platkright
        break;
        
    case playerup:
        sprite_index = platkup
        break;
    }
    
if (image_index >= 3 && canattack == true) {
    var xx = 0
    var yy = 0
    switch (sprite_index) {
        case platkdown:
            xx = x;
            yy = y+yyvar1;
            break;
        
        case platkleft:
            xx = x+xxvar2;
            yy = y+yyvar2;
            break;

        case platkright:
            xx = x+xxvar3;
            yy = y+yyvar3;
        break;
        
        case platkup:
            xx = x;
            yy = y+yyvar4;
            break;
        }
var damage = instance_create(xx, yy, obj_dmg);
damage.creator = id;
canattack = false;
}

