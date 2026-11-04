// Comprobar si puede hacer daño
if (!other.dead && other.invincibility_timer <= 0) {

    // Causar daño
    other.hp -= 1;

    // Activar invulnerabilidad
    other.invincibility_timer = other.invincibility_duration;

    // Indicar que recibió daño
    other.taking_damage = true;

    // Comprobar muerte
    if (other.hp <= 0) {
        other.hp = 0;
        other.dead = true;
    }
}