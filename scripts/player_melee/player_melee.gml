function player_update_melee() {

    attack_hitbox_active = false;

    if (
        attacking
        && image_index >= 2
        && image_index < 4
    ) {
        attack_hitbox_active = true;

        switch (attack_direction) {
            case 0:
                attack_hitbox_left = x + 14;
                attack_hitbox_right = x + 36;
                attack_hitbox_top = y - 106;
                attack_hitbox_bottom = y - 25;
                break;

            case 1:
                attack_hitbox_left = x + 10;
                attack_hitbox_right = x + 60;
                attack_hitbox_top = y - 43;
                attack_hitbox_bottom = y - 17;
                break;

            case -1:
                attack_hitbox_left = x - 60;
                attack_hitbox_right = x - 10;
                attack_hitbox_top = y - 43;
                attack_hitbox_bottom = y - 17;
                break;
        }
    }

    if (!attack_hitbox_active) {
        return;
    }

    var hit_list = ds_list_create();

    collision_rectangle_list(
        attack_hitbox_left,
        attack_hitbox_top,
        attack_hitbox_right,
        attack_hitbox_bottom,
        par_enemy,
        false,
        true,
        hit_list,
        false
    );

    for (var i = 0; i < ds_list_size(hit_list); i++) {
        var enemy = ds_list_find_value(hit_list, i);

        if (enemy.last_player_attack != attack_sequence) {
            enemy.last_player_attack = attack_sequence;
            enemy.hp -= attack_damage;
            enemy.hit_flash_timer = 6;

            var impact_x = clamp(
                enemy.x,
                attack_hitbox_left,
                attack_hitbox_right
            );

            var impact_y = clamp(
                enemy.y - 24,
                attack_hitbox_top,
                attack_hitbox_bottom
            );

            instance_create_depth(
                impact_x,
                impact_y,
                depth - 1,
                obj_melee_impact
            );

            var knockback_direction = sign(
                enemy.x - x
            );

            if (knockback_direction == 0) {
                knockback_direction = facing;
            }

            enemy.knockback_speed =
                knockback_direction * 3;
        }
    }

    ds_list_destroy(hit_list);
}