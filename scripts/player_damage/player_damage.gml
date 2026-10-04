function player_receive_damage() {

    if (
        invincibility_timer > 0
        || dash_active
    ) {
        return;
    }

    var touching_enemy = instance_place(
        x,
        y,
        par_enemy
    );

    if (touching_enemy == noone) {
        return;
    }

    // El escudo bloquea el daño
    if (shield_active) {
        if (shield_hit_timer <= 0) {
            shield_durability -=
                touching_enemy.contact_damage * 25;

            shield_hit_timer = 15;
            shield_regen_timer = shield_regen_delay;

            var enemy_push = sign(
                touching_enemy.x - x
            );

            if (enemy_push == 0) {
                enemy_push = facing;
            }

            touching_enemy.knockback_speed =
                enemy_push * 2;

            if (shield_durability <= 0) {
                shield_durability = 0;
                shield_active = false;
                shield_broken = true;
                shield_break_timer = shield_break_duration;
                shield_anim_state = 3;
            }
        }

        return;
    }

    // Restar vida
    hp -= touching_enemy.contact_damage;
    invincibility_timer = invincibility_duration;
    damage_freeze_timer = damage_freeze_duration;

    // Cancelar acciones
    attacking = false;
    casting_fireball = false;
    throwing_grenade = false;
    dash_active = false;

    fireball_spawned = false;
    grenade_spawned = false;

    shield_active = false;
    shield_anim_state = 0;

    if (hp <= 0) {
        hp = 0;
        dead = true;
        taking_damage = false;
    }
    else {
        taking_damage = true;
    }

    // Granos expulsados
    var kernel_amount;

    if (dead) {
        kernel_amount = 10;
    }
    else {
        kernel_amount = 4;
    }

    repeat (kernel_amount) {
        instance_create_depth(
            x + random_range(-8, 8),
            y - random_range(25, 42),
            depth - 1,
            obj_corn_kernel_particle
        );
    }

    // Retroceso horizontal
    var push_direction = sign(
        x - touching_enemy.x
    );

    if (push_direction == 0) {
        push_direction = -facing;
    }

    repeat (8) {
        if (!place_meeting(
            x + push_direction,
            y,
            obj_solid
        )) {
            x += push_direction;
        }
    }
}