// Tamaño fijo de la cámara.
cam_ancho = 1365;
cam_alto = 768;

// Crear una cámara propia.
// El seguimiento se realiza en el evento Fin de paso.
mi_camara = camera_create_view(
    0, 0,
    cam_ancho, cam_alto,
    0,
    noone,
    -1, -1,
    0, 0
);

// Activar únicamente la vista 0.
view_enabled = true;

for (var i = 0; i < 8; i++) {
    view_visible[i] = false;
}

view_visible[0] = true;
view_camera[0] = mi_camara;

// Área de presentación.
view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = 1280;
view_hport[0] = 720;

window_set_fullscreen(false);
window_set_size(1280, 720);
window_center();