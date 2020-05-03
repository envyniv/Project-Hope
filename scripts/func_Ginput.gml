///get_input

//if gamepad is connected use gamepad else use keyboard
    
//Camera
downlook = keyboard_check(ord('I'));
leftlook = keyboard_check(ord('J'));
uplook = keyboard_check(ord('K'));
rightlook = keyboard_check(ord('L'));

//Movement
down = keyboard_check(vk_down);
left = keyboard_check(vk_left);
up = keyboard_check(vk_up);
right = keyboard_check(vk_right);

//Other
key_attack = keyboard_check_pressed(ord('Z'));
key_dodge = keyboard_check_pressed(ord('A'))
key_run = keyboard_check(ord('X'));
key_start = keyboard_check(vk_enter);

    
//alias
anykey = vk_nokey
nodir = !down&&!left&&!right&&!up
