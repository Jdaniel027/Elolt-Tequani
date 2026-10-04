function player_update_state() {

    if (
        !attacking
        && !casting_fireball
        && !throwing_grenade
    ) {
        if (!on_ground) {
            if (vertical_speed < 0) {
                state = PlayerState.JUMP;
            }
            else {
                state = PlayerState.FALL;
            }
        }
        else if (keyboard_check(vk_down)) {
            state = PlayerState.CROUCH;
        }
        else if (keyboard_check(vk_up) && move == 0) {
            state = PlayerState.LOOK_UP;
        }
        else if (move != 0) {
            state = PlayerState.WALK;
        }
        else {
            state = PlayerState.IDLE;
        }
    }
}


function player_update_animation() {

    var new_sprite = sprite_index;

    if (dead) {
        if (facing == 1) {
            new_sprite = spr_player_death_right;
        }
        else {
            new_sprite = spr_player_death_left;
        }
    }
    else if (taking_damage) {
        if (facing == 1) {
            new_sprite = spr_player_hurt_right;
        }
        else {
            new_sprite = spr_player_hurt_left;
        }
    }
    else if (shield_anim_state == 3) {
        new_sprite = spr_player_shield_break;
    }
    else if (attacking) {
        switch (attack_direction) {
            case 0:
                new_sprite = spr_player_attack_melee_up;
                break;

            case 1:
                new_sprite = spr_player_attack_melee_right;
                break;

            case -1:
                new_sprite = spr_player_attack_melee_left;
                break;
        }
    }
    else if (casting_fireball) {
        if (facing == 1) {
            new_sprite = spr_player_cast_fireball_right;
        }
        else {
            new_sprite = spr_player_cast_fireball_left;
        }
    }
    else if (throwing_grenade) {
        if (facing == 1) {
            new_sprite = spr_player_throw_grenade_right;
        }
        else {
            new_sprite = spr_player_throw_grenade_left;
        }
    }
    else if (shield_anim_state == 1) {
        new_sprite = spr_player_shield_activate;
    }
    else if (shield_anim_state == 2) {
        new_sprite = spr_player_shield_hold;
    }
    else if (shield_anim_state == 4) {
        new_sprite = spr_player_shield_activate;
    }
    else if (!on_ground) {
        if (move > 0) {
            new_sprite = spr_player_jump_right;
        }
        else if (move < 0) {
            new_sprite = spr_player_jump_left;
        }
        else {
            new_sprite = spr_player_jump_up;
        }
    }
    else if (keyboard_check(vk_down)) {
        new_sprite = spr_player_crouch;
    }
    else if (keyboard_check(vk_up) && move == 0) {
        new_sprite = spr_player_look_up;
    }
    else if (move > 0) {
        new_sprite = spr_player_walk_right;
    }
    else if (move < 0) {
        new_sprite = spr_player_walk_left;
    }
    else if (facing == 1) {
        new_sprite = spr_player_idle_right;
    }
    else {
        new_sprite = spr_player_idle_left;
    }

    // Cambiar sprite sin reiniciarlo cada step
    if (sprite_index != new_sprite) {
        sprite_index = new_sprite;

        if (shield_anim_state == 4) {
            image_index = image_number - 1;
            image_speed = -1;
        }
        else {
            image_index = 0;
            image_speed = 1;
        }
    }

    // Control de reproducción
    if (shield_anim_state == 4) {
        image_speed = -1;
    }
    else if (
        attacking
        || casting_fireball
        || throwing_grenade
        || shield_anim_state == 1
        || shield_anim_state == 3
    ) {
        image_speed = 1;
    }
    else if (shield_anim_state == 2) {
        image_index = 0;
        image_speed = 0;
    }
    else if (sprite_index == spr_player_look_up) {
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
    }
    else if (sprite_index == spr_player_crouch) {
        if (image_index >= 1) {
            image_index = 1;
            image_speed = 0;
        }
    }
    else {
        image_speed = 1;
    }

    if (
        damage_freeze_timer > 0
        && (taking_damage || dead)
    ) {
        image_speed = 0;
    }
}