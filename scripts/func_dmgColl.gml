
if (other.id != creator) { //if the id of the object that collided with the dmgobj is different to the creator, then damage the object
    other.hp -= damage;
    var dir = point_direction(x, y, other.x, other.y)
    var xforce = lengthdir_x(knockback, dir);
    var yforce = lengthdir_y(knockback, dir);
    var force = xforce+yforce/2
    //if (damage <= 10 && damage >= 25) {trigger minigame}
    with (other) {
    	//FIXME: add knockback
        motion_add(dir, force)
    }

}