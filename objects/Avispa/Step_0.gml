// ==================================================
// COMPROBAR MUERTE
// ==================================================

if (hp <= 0 || muerta) {
    muerta = true;
    instance_destroy();
    exit;
}


// ==================================================
// TEMPORIZADOR DE IMPACTO
// ==================================================

if (hit_flash_timer > 0) {
    hit_flash_timer--;
}


// ==================================================
// RETROCESO POR GOLPES
// ==================================================

if (abs(knockback_speed) > 0.1) {

    x += knockback_speed;
    knockback_speed *= 0.75;

}
else {

    knockback_speed = 0;

}


// ==================================================
// PERSECUCIÓN
// ==================================================

if (instance_exists(obj_player)) {

    var distancia = point_distance(
        x, y,
        obj_player.x, obj_player.y
    );

    // Orientar el sprite hacia el jugador
    if (obj_player.x < x) {
        image_xscale = 1;
    }
    else if (obj_player.x > x) {
        image_xscale = -1;
    }

    // No perseguir mientras recibe retroceso
    if (knockback_speed == 0) {

        switch (estado) {

            // ESTADO 0: ESPERANDO
            case 0:

                if (distancia <= distancia_deteccion) {

                    estado = 1;

                    lado_objetivo =
                        (obj_player.x > x) ? 1 : -1;

                    if (distancia <= distancia_ataque) {
                        estado = 2;
                    }
                }

            break;


            // ESTADO 1: PERSIGUIENDO
            case 1:

                if (
                    distancia <= distancia_ataque ||
                    (obj_player.x - x) * lado_objetivo <= 0
                ) {

                    estado = 2;

                }
                else {

                    var objetivo_x = obj_player.x -
                        (lado_objetivo * distancia_ataque);

                    var objetivo_y = obj_player.y;

                    var direccion = point_direction(
                        x, y,
                        objetivo_x, objetivo_y
                    );

                    var distancia_objetivo = point_distance(
                        x, y,
                        objetivo_x, objetivo_y
                    );

                    var avance = min(
                        velocidad,
                        distancia_objetivo
                    );

                    x += lengthdir_x(avance, direccion);
                    y += lengthdir_y(avance, direccion);
                }

            break;


            // ESTADO 2: EN PAUSA
            case 2:

                if (distancia >= distancia_reanudacion) {

                    estado = 1;

                    lado_objetivo =
                        (obj_player.x > x) ? 1 : -1;
                }

            break;
        }
    }
}