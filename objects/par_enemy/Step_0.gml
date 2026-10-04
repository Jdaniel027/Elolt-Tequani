// ==================================================
// DESTELLO AL RECIBIR DAÑO
// ==================================================

if (hit_flash_timer > 0) {

    hit_flash_timer -= 1;
    image_blend = c_yellow;

}
else {

    image_blend = c_white;
}


// ==================================================
// RETROCESO
// ==================================================

if (abs(knockback_speed) > 0.1) {

    if (!place_meeting(x + knockback_speed, y, obj_solid)) {
        x += knockback_speed;
    }
    else {
        knockback_speed = 0;
    }

    knockback_speed *= 0.75;

}
else {

    knockback_speed = 0;
}