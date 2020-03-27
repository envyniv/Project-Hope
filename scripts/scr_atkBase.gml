//general script for attacking functions
var platk=plarkdown||platkleft||platkright||platkup
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
canattack = false;

//atk
if (sprite_index==platk)
{
ds_list_clear(enhitbyatk)
}

//hitbox and check for hits
mask_index=hb_platk


