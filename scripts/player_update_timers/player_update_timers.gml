function player_update_timers() {

    // Cooldown de bola de fuego
    fireball_cooldown = max(
        0,
        fireball_cooldown - 1
    );

    // Cooldown de granada
    grenade_cooldown = max(
        0,
        grenade_cooldown - 1
    );

    // Cooldown de dash
    dash_cooldown = max(
        0,
        dash_cooldown - 1
    );

    // Invulnerabilidad después de recibir daño
    if (invincibility_timer > 0) {
        invincibility_timer -= 1;
    }

    // Evitar múltiples impactos seguidos en el escudo
    if (shield_hit_timer > 0) {
        shield_hit_timer -= 1;
    }

    // Pausa visual al recibir daño
    if (damage_freeze_timer > 0) {
        damage_freeze_timer -= 1;
    }
}