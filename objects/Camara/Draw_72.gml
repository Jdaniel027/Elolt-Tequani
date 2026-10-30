// Mantener la superficie de dibujo al tamaño del puerto.
if (surface_exists(application_surface)) {

    if (
        surface_get_width(application_surface) != 1280
        || surface_get_height(application_surface) != 720
    ) {
        surface_resize(application_surface, 1280, 720);
    }
}