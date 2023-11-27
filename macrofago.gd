extends CharacterBody2D


const SPEED = 150


func _physics_process(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_key_pressed(KEY_W) or Input.is_action_pressed("ui_up") : 
		velocity.y = -SPEED
	if Input.is_key_pressed(KEY_A) or Input.is_action_pressed("ui_left") : 
		velocity.x = -SPEED
	if Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down") : 
		velocity.y = SPEED
	if Input.is_key_pressed(KEY_D) or Input.is_action_pressed("ui_right") : 
		velocity.x = SPEED
	detect_distance()
	move_and_slide()
	
func detect_distance() : 
	
	if $Down.is_colliding() :
		print("Down: " + str(position.distance_to($Down.get_collider().position)))
		print($Down.get_collider().name)
	if $Right.is_colliding() :
		print("Right: " + str(position.distance_to($Right.get_collider().position)))
	if $Left.is_colliding() :
		print("Left: " + str(position.distance_to($Left.get_collider().position)))
	if $Up.is_colliding() :
		print("Up: " + str(position.distance_to($Up.get_collider().position)))
	if $Down_Right.is_colliding() :
		print("DownRight: " + str(position.distance_to($Down_Right.get_collider().position)))
	if $Down_Left.is_colliding() :
		print("DownLeft: " + str(position.distance_to($Down_Left.get_collider().position)))
	if $Up_Right.is_colliding() :
		print("UpRight: " + str(position.distance_to($Up_Right.get_collider().position)))
	if $Up_Left.is_colliding() :
		print("UpLeft: " + str(position.distance_to($Up_Left.get_collider().position)))
