// ==================================================
// MOVIMIENTO E IA
// ==================================================

velocidad = 2;

distancia_deteccion = 200;
distancia_ataque = 35;
distancia_reanudacion = 70;

// Estados:
// 0 = Esperando
// 1 = Persiguiendo
// 2 = En pausa

estado = 0;
lado_objetivo = 0;


// ==================================================
// VIDA Y DAÑO
// ==================================================

max_hp = 3;
hp = max_hp;

// Daño de contacto al jugador
contact_damage = 1;


// ==================================================
// SISTEMA DE COMBATE
// ==================================================

// Necesarias para las funciones del jugador
knockback_speed = 0;
hit_flash_timer = 0;
last_player_attack = -1;


// ==================================================
// ESTADO DE MUERTE
// ==================================================

muerta = false;