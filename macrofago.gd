extends CharacterBody2D


const SPEED = 150
const class_dict = {"0":0, "1":1,"2":2, "3": 3}

var input_array = Array()
var lifeTime = Controller.mac_life_time
var baseVel = Vector2(0,0)
var id = 0;
var points = 0
var stattrak = 0
func _init():
	Controller.connect("updateMacroSpeedSignal", self.setBaseVel)

func _ready():
	$AnimatedSprite2D.play("Static")
	Controller.appendMacroInstances(self)
	$Timer.wait_time = lifeTime
	$Timer.start()
	

func setBaseVel(vel: Vector2, _id):
	if id == _id:
		baseVel = vel

func _physics_process(delta):
	velocity = baseVel
	
	if Input.is_key_pressed(KEY_W) : 
		velocity.y = -SPEED
	if Input.is_key_pressed(KEY_A) : 
		velocity.x = -SPEED
	if Input.is_key_pressed(KEY_S) : 
		velocity.y = SPEED
	if Input.is_key_pressed(KEY_D) : 
		velocity.x = SPEED
	detect_distance()
	move_and_slide()
	
func detect_distance() : 
	
	"""if $Down.is_colliding() :
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
"""
func _on_timer_timeout():
	death()
func death():
	points -= 100
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	self.queue_free()
func increase_timer():
	print(stattrak)
	$Timer.wait_time = $Timer.time_left + lifeTime
	$Timer.start()
	if stattrak >= 2:
		print(stattrak)
		Controller.spawnMacrof(Vector2(position.x + 10, position.y +10))
		stattrak = 0
	else: 
		stattrak += 1
	
