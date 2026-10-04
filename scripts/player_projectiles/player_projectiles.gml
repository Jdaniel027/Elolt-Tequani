function player_spawn_projectiles() {

    // Bola de fuego en el frame 4
    if (
        casting_fireball
        && !fireball_spawned
        && image_index >= 3
    ) {
        var fireball = instance_create_depth(
            x + facing * 40,
            y - 22,
            depth - 1,
            obj_player_fireball
        );

        fireball.move_direction = facing;
        fireball_spawned = true;
    }

    // Granada en el frame 4
    if (
        throwing_grenade
        && !grenade_spawned
        && image_index >= 3
    ) {
        var grenade = instance_create_depth(
            x + facing * 42,
            y - 50,
            depth - 1,
            obj_corn_grenade
        );

        grenade.horizontal_speed = facing * 4;
        grenade.vertical_speed = -5;
        grenade_spawned = true;
    }
}