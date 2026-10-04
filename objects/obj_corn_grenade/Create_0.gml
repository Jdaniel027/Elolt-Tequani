// ==================================================
// MOVIMIENTO
// ==================================================

horizontal_speed = 0;
vertical_speed = -5;
gravity_force = 0.30;

// ==================================================
// REBOTE
// ==================================================

bounce_count = 0;
max_bounces = 1;
landed = false;

// ==================================================
// EXPLOSIÓN
// ==================================================

damage = 2;
explosion_radius = 45;

// Aproximadamente 1.2 segundos
fuse_timer = round(room_speed * 1.2);

exploded = false;
explosion_timer = 0;
explosion_duration = 10;