// ==================================================
// MOVIMIENTO
// ==================================================

move = 0;
on_ground = false;

move_speed = 3;
vertical_speed = 0;
jump_speed = -8;
gravity_force = 0.45;
max_fall_speed = 10;

// 1 = derecha, -1 = izquierda
facing = 1;
state = PlayerState.IDLE;


// ==================================================
// VIDA, DAÑO Y MUERTE
// ==================================================

max_hp = 5;
hp = max_hp;

invincibility_timer = 0;
invincibility_duration = 60;

taking_damage = false;
dead = false;

damage_freeze_timer = 0;
damage_freeze_duration = 4;


// ==================================================
// BLOQUEO DE CONTROLES
// ==================================================

shield_locked = false;
player_locked = false;


// ==================================================
// ATAQUE CUERPO A CUERPO
// ==================================================

attacking = false;

// -1 = izquierda, 0 = arriba, 1 = derecha
attack_direction = 0;
attack_damage = 1;
attack_sequence = 0;

attack_hitbox_active = false;
attack_hitbox_left = 0;
attack_hitbox_top = 0;
attack_hitbox_right = 0;
attack_hitbox_bottom = 0;

// Cambiar a true solamente para depuración
show_attack_hitbox = false;


// ==================================================
// BOLA DE FUEGO
// ==================================================

casting_fireball = false;
fireball_spawned = false;

fireball_cooldown = 0;
fireball_cooldown_max = 30;


// ==================================================
// GRANADA DE MAÍZ
// ==================================================

throwing_grenade = false;
grenade_spawned = false;

grenade_cooldown = 0;
grenade_cooldown_max = 60;


// ==================================================
// ESCUDO DE HOJAS
// ==================================================

shield_max = 100;
shield_durability = shield_max;

shield_active = false;
shield_broken = false;

shield_regen_timer = 0;
shield_regen_delay = 120;

shield_break_timer = 0;
shield_break_duration = 180;

shield_hit_timer = 0;

// 0 normal, 1 activando, 2 sostenido,
// 3 roto, 4 desactivando
shield_anim_state = 0;


// ==================================================
// DASH
// ==================================================

dash_active = false;
dash_direction = 1;

dash_speed = 10;
dash_timer = 0;
dash_duration = 10;

dash_cooldown = 0;
dash_cooldown_max = 30;

air_dash_available = true;

dash_trail_timer = 0;
dash_trail_interval = 2;