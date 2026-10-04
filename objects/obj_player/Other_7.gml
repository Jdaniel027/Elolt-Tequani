// ==================================================
// MUERTE
// ==================================================

if (
    dead
    && (
        sprite_index == spr_player_death_right
        || sprite_index == spr_player_death_left
    )
) {
    image_index = image_number - 1;
    image_speed = 0;

    // Temporal hasta implementar checkpoints
    room_restart();
}


// ==================================================
// RECIBIR DAÑO
// ==================================================

else if (
    taking_damage
    && (
        sprite_index == spr_player_hurt_right
        || sprite_index == spr_player_hurt_left
    )
) {
    taking_damage = false;
    image_speed = 1;
}


// ==================================================
// ESCUDO: TERMINAR ACTIVACIÓN
// ==================================================

else if (
    shield_anim_state == 1
    && sprite_index == spr_player_shield_activate
) {
    if (shield_active) {
        shield_anim_state = 2;
    }
    else {
        shield_anim_state = 4;
    }

    image_speed = 1;
}


// ==================================================
// ESCUDO: TERMINAR DESACTIVACIÓN
// ==================================================

else if (
    shield_anim_state == 4
    && sprite_index == spr_player_shield_activate
) {
    shield_anim_state = 0;
    image_index = 0;
    image_speed = 1;
}


// ==================================================
// ESCUDO: TERMINAR RUPTURA
// ==================================================

else if (
    shield_anim_state == 3
    && sprite_index == spr_player_shield_break
) {
    // Sigue roto, pero se liberan los controles
    shield_anim_state = 0;
    image_speed = 1;
}


// ==================================================
// ATAQUE CUERPO A CUERPO
// ==================================================

else if (attacking) {
    attacking = false;
    attack_direction = 0;
    attack_hitbox_active = false;
    image_speed = 1;
}


// ==================================================
// BOLA DE FUEGO
// ==================================================

else if (casting_fireball) {
    casting_fireball = false;
    fireball_spawned = false;
    image_speed = 1;
}


// ==================================================
// GRANADA
// ==================================================

else if (throwing_grenade) {
    throwing_grenade = false;
    grenade_spawned = false;
    image_speed = 1;
}