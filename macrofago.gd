extends CharacterBody2D


const SPEED = 150
const class_dict = {"0":0, "1":1,"2":2,}

var input_array = Array()
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
		var ray_size = Vector2(0,0).distance_to($Down.target_position)
		input_array.append(position.distance_to($Down.get_collider().position)/ray_size)
		input_array.append(class_dict[$Down.get_collider().get_groups()[0]])
	if $Right.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Right.target_position)
		input_array.append(position.distance_to($Right.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Right.get_collider().get_groups()[0]])
	if $Left.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Left.target_position)
		input_array.append(position.distance_to($Left.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Left.get_collider().get_groups()[0]])
	if $Up.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Up.target_position)
		input_array.append(position.distance_to($Up.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Up.get_collider().get_groups()[0]])
	if $Down_Right.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Down_Right.target_position)
		input_array.append(position.distance_to($Down_Right.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Down_Right.get_collider().get_groups()[0]])
	if $Down_Left.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Down_Left.target_position)
		input_array.append(position.distance_to($Down_Left.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Down_Left.get_collider().get_groups()[0]])
	if $Up_Right.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Up_Right.target_position)
		input_array.append(position.distance_to($Up_Right.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Up_Right.get_collider().get_groups()[0]])
	if $Up_Left.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Up_Left.target_position)
		input_array.append(position.distance_to($Up_Left.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Up_Left.get_collider().get_groups()[0]])
