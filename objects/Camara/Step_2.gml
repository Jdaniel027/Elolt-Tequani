if (instance_exists(obj_player)) {

    var _player = instance_find(obj_player, 0);

    // Centrar horizontalmente en el jugador.
    var _cam_x = _player.x - cam_ancho / 2;

    // Evitar que la cámara salga por los lados de la room.
    _cam_x = clamp(
        _cam_x,
        0,
        max(0, room_width - cam_ancho)
    );

    // Mantener toda la altura del mapa visible.
    camera_set_view_pos(mi_camara, _cam_x, 0);
}