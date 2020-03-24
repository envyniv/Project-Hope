///get_input

//if gamepad is connected use gamepad else use keyboard

if (gamepad_is_connected(0)) {

    //Movement
    right = (gamepad_axis_value(0, gp_axislh) >= .5);
    left = (gamepad_axis_value(0, gp_axislh) <= -.5);
    up = (gamepad_axis_value(0, gp_axislv) <= .5);
    down = (gamepad_axis_value(0, gp_axislv) >= -.5);
    
    //Movement but with pad
    right1 = gamepad_button_check(0, gp_padr);
    left1 = gamepad_button_check(0, gp_padl);
    up1 = gamepad_button_check(0, gp_padu);
    down1 = gamepad_button_check (0, gp_padd);
    
    //Camera
    rightlook = (gamepad_axis_value(0, gp_axisrh) >= .5);
    leftlook = (gamepad_axis_value(0, gp_axisrh) <= -.5);
    uplook = (gamepad_axis_value(0, gp_axisrv) <= .5);
    downlook = (gamepad_axis_value(0, gp_axisrv) >= -.5);
    
    //Other
    key_attack = gamepad_button_check(0, gp_shoulderrb);
    key_dodge = gamepad_button_check_pressed(0, gp_face2)
    key_run = gamepad_button_check(0, gp_stickl);
    key_interact = gamepad_button_check(0, gp_shoulderr);
    key_start = gamepad_button_check (0, gp_start);
    } else {
    
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
}

//DeadZone
if (gamepad_is_connected(0)) {
    gamepad_set_axis_deadzone(1, .085)
    xaxis = gamepad_axis_value(1, gp_axislh);
    yaxis = gamepad_axis_value(1, gp_axislv);
    }
    
//alias
anykey = vk_nokey
nodir = !down&&!left&&!right&&!up

