vertical_speed += gravity_force;

x += horizontal_speed;
y += vertical_speed;

life -= 1;

if (life <= 0) {
    instance_destroy();
}