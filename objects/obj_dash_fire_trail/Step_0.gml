if (instance_exists(player_owner)) {

    x = player_owner.x
        - follow_direction * 70;

    y = player_owner.y;

}
else {

    instance_destroy();
}