// Si la avispa murió, no ejecutar su IA
if (muerta) {
    exit;
}

// Controlar el tiempo entre ataques
if (!puede_atacar) {
    tiempo_entre_ataques--;

    if (tiempo_entre_ataques <= 0) {
        puede_atacar = true;
    }
}
///////////////////////////////////////////////////
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

    switch (estado) {

        // ESTADO 0: ESPERANDO
        case 0:

            if (distancia <= distancia_deteccion) {

                estado = 1;

                // Elegir el lado inicial
                lado_objetivo = (obj_player.x > x) ? 1 : -1;

                // Si ya está cerca, comenzar en pausa
                if (distancia <= distancia_ataque) {
                    estado = 2;
                }
            }

        break;


        // ESTADO 1: PERSIGUIENDO
        case 1:

            // Comprobar si alcanzó al jugador
            // o si el jugador cruzó al otro lado
            if (
                distancia <= distancia_ataque ||
                (obj_player.x - x) * lado_objetivo <= 0
            ) {

                estado = 2;

            }
            else {

                // Mantener el lado elegido
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

            // No mover la avispa mientras el jugador
            // permanezca cerca.

            if (distancia >= distancia_reanudacion) {

                estado = 1;

                // Elegir el lado desde la posición actual
                lado_objetivo = (obj_player.x > x) ? 1 : -1;
            }

        break;
    }
}
if (vida <= 0 && !muerta) {
    muerta = true;
    instance_destroy();
}