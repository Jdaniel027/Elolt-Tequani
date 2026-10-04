trail_alpha -= trail_fade_speed;

if (trail_alpha <= 0) {
    instance_destroy();
}