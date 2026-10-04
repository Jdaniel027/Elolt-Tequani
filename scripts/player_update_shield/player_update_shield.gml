function player_update_shield() {

    var shield_was_active = shield_active;

    // ==================================================
    // ESCUDO ROTO
    // ==================================================

    if (shield_broken) {

        shield_active = false;
        shield_break_timer -= 1;

        // Recuperar parcialmente el escudo
        if (shield_break_timer <= 0) {

            shield_broken = false;
            shield_durability = 25;
            shield_regen_timer = shield_regen_delay;
        }
    }

    // ==================================================
    // ESCUDO DISPONIBLE
    // ==================================================

    else {

        shield_active =
            keyboard_check(vk_shift)
            && !attacking
            && !casting_fireball
            && !throwing_grenade
            && !dash_active
            && !taking_damage
            && !dead
            && shield_durability > 0;

        // Comenzar la animación de activación
        if (
            shield_active
            && !shield_was_active
        ) {
            shield_anim_state = 1;
        }

        // Comenzar la animación de desactivación
        if (
            !shield_active
            && shield_was_active
        ) {
            if (
                shield_anim_state == 1
                || shield_anim_state == 2
            ) {
                shield_anim_state = 4;
            }
        }

        // ==================================================
        // REGENERACIÓN
        // ==================================================

        if (shield_active) {

            shield_regen_timer =
                shield_regen_delay;

        }
        else if (shield_regen_timer > 0) {

            shield_regen_timer -= 1;

        }
        else {

            shield_durability = min(
                shield_max,
                shield_durability + 0.25
            );
        }
    }

    // Bloqueo causado por animaciones del escudo
    shield_locked =
        shield_anim_state == 3
        || shield_anim_state == 4;

    // Bloqueo general del jugador
    player_locked =
        shield_locked
        || taking_damage
        || dead;
}