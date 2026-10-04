// Ejecutar el Step de par_enemy
event_inherited();

// Destruir al quedarse sin vida
if (hp <= 0) {
    instance_destroy();
}