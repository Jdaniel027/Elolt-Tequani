// 1. Actualizar cooldowns y temporizadores
player_update_timers();

// 2. Comprobar el suelo antes de leer acciones
player_check_ground();

// 3. Activar, regenerar o romper el escudo
player_update_shield();

// 4. Leer dirección y botones de movimiento
player_read_input();

// 5. Iniciar ataque, disparo, granada o dash
player_start_actions();

// 6. Movimiento, salto, gravedad y colisiones
player_update_movement();

// 7. Determinar el estado lógico
player_update_state();

// 8. Seleccionar y controlar la animación
player_update_animation();

// 9. Crear proyectiles en el frame correspondiente
player_spawn_projectiles();

// 10. Activar hitbox y dañar enemigos
player_update_melee();

// 11. Recibir o bloquear daño enemigo
player_receive_damage();