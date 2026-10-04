# Personaje principal — Guía de integración

Este documento describe cómo integrar y configurar el personaje principal del proyecto en GameMaker.

## Estado actual

El personaje incluye:

- Movimiento horizontal y colisiones.
- Salto, caída, agacharse y mirar arriba.
- Ataque cuerpo a cuerpo horizontal y hacia arriba.
- Bola de fuego.
- Granada de maíz.
- Escudo de hojas con durabilidad, ruptura y regeneración.
- Dash terrestre y un dash aéreo antes de tocar el suelo.
- Vida, invulnerabilidad y retroceso horizontal.
- Animaciones de daño y muerte.
- Partículas de granos al recibir daño.
- Estela de dash y efecto de impacto cuerpo a cuerpo.

## Controles

| Acción | Tecla |
| --- | --- |
| Moverse | Flechas izquierda/derecha |
| Mirar arriba | Flecha arriba |
| Agacharse | Flecha abajo |
| Saltar | Espacio |
| Ataque cuerpo a cuerpo | X |
| Ataque hacia arriba | Arriba + X |
| Bola de fuego | Z |
| Dash | C |
| Granada de maíz | V |
| Escudo de hojas | Shift |

## Objetos requeridos

```text
Objects
├── Player
│   ├── Core
│   │   └── obj_player
│   ├── Projectiles
│   │   ├── obj_player_fireball
│   │   └── obj_corn_grenade
│   └── Effects
│       ├── obj_corn_kernel_particle
│       ├── obj_dash_trail
│       └── obj_melee_impact
├── Enemies
│   ├── Parents
│   │   └── par_enemy
│   └── Test
│       └── obj_training_dummy
└── World
    └── obj_solid
```

## Scripts del jugador

| Script | Responsabilidad |
| --- | --- |
| `player_update_timers` | Cooldowns, invulnerabilidad y pausa de impacto |
| `player_update_shield` | Activación, regeneración, ruptura y bloqueo del escudo |
| `player_input_actions` | Entrada del teclado e inicio de ataques y dash |
| `player_movement` | Suelo, movimiento, salto, gravedad, colisiones y dash |
| `player_animation` | Estado lógico y selección de sprites |
| `player_projectiles` | Creación de bola de fuego y granada en su frame correcto |
| `player_melee` | Hitbox, daño, efecto y retroceso de enemigos |
| `player_damage` | Daño de contacto, escudo, vida, partículas y muerte |

El evento Paso de `obj_player` solamente coordina estos sistemas en el orden correcto.

## Eventos de `obj_player`

- **Crear:** valores iniciales y configuración.
- **Paso:** llamadas ordenadas a los sistemas del jugador.
- **Fin de la animación:** finaliza ataques y transiciones del escudo, daño y muerte.
- **Dibujar:** sprite, parpadeo, vibración y hitbox opcional.
- **Dibujar GUI:** vida y durabilidad del escudo provisionales.

## Integrar al personaje en una habitación

1. Colocar una instancia de `obj_player` en la habitación.
2. Construir el suelo y las paredes con instancias de `obj_solid`.
3. No marcar `obj_player` como objeto sólido ni activar física integrada.
4. Mantener `spr_player_mask` como máscara de colisión de `obj_player`.
5. Colocar enemigos que hereden de `par_enemy`.
6. Ejecutar y comprobar que el jugador aparece apoyado sobre el suelo.

El origen de los sprites del jugador debe permanecer en:

```text
X = 64
Y = 64
```

Los sprites tienen cuadros de `128 × 64 px`.

## Contrato de los enemigos

Los enemigos que interactúen con el jugador deben heredar de `par_enemy` y disponer de estas variables:

```gml
hp
contact_damage
last_player_attack
hit_flash_timer
knockback_speed
```

Valores iniciales de ejemplo:

```gml
hp = 3;
contact_damage = 1;
last_player_attack = -1;
hit_flash_timer = 0;
knockback_speed = 0;
```

`last_player_attack` evita recibir daño varias veces durante el mismo ataque cuerpo a cuerpo.

## Valores configurables

Los siguientes valores se encuentran en el evento Crear de `obj_player`.

### Movimiento

```gml
move_speed = 3;
jump_speed = -8;
gravity_force = 0.45;
max_fall_speed = 10;
```

### Vida

```gml
max_hp = 5;
invincibility_duration = 60;
damage_freeze_duration = 4;
```

### Ataques

```gml
attack_damage = 1;
fireball_cooldown_max = 30;
grenade_cooldown_max = 60;
```

### Escudo

```gml
shield_max = 100;
shield_regen_delay = 120;
shield_break_duration = 180;
```

### Dash

```gml
dash_speed = 10;
dash_duration = 10;
dash_cooldown_max = 30;
dash_trail_interval = 2;
```

Los tiempos se expresan en steps. Con una habitación a 60 FPS, `60 steps` equivalen aproximadamente a un segundo.

## Depuración de ataques

En el evento Crear:

```gml
show_attack_hitbox = false;
```

Cambiarlo temporalmente a `true` muestra la hitbox roja del ataque cuerpo a cuerpo.

No debe quedar activado en la versión final.

## Prioridad de acciones

El jugador no puede iniciar varias acciones incompatibles simultáneamente. El daño, la muerte, ciertas transiciones del escudo y las animaciones de ataque bloquean temporalmente los controles.

El orden de las llamadas del evento Paso no debe modificarse sin volver a probar todas las acciones.

## Comportamientos provisionales

- Al terminar la animación de muerte se utiliza `room_restart()`.
- La vida y el escudo se dibujan como texto y barra provisionales.
- Los controles están escritos directamente con teclado y todavía no usan un sistema remapeable.
- Los sonidos se agregarán al final del proceso de pulido.
- Los valores de daño y cooldown todavía deben balancearse con los jefes y el diseño final de niveles.

## Prueba rápida después de integrar

1. Caminar y saltar en ambas direcciones.
2. Colisionar con paredes, techo y suelo.
3. Probar los tres sentidos del ataque cuerpo a cuerpo.
4. Disparar y lanzar granadas en ambas direcciones.
5. Activar, soltar, romper y recuperar el escudo.
6. Hacer dash en suelo y una vez en el aire.
7. Recibir daño y comprobar la invulnerabilidad.
8. Perder toda la vida y verificar la animación de muerte.

