extends CharacterBody2D
const class_dict = {"0":0, "1":1,"2":2, "3": 3}

var SPEED = 150
var life = 5
var points = 0
var id = 0;
var baseVel = Vector2(0,0)
var signal_vel = Vector2(0,0)
var lifeTime = Controller.mac_life_time
var stattrak = 0
const type = "bacteria"
var input_array = Array()
func _init():
	Controller.connect("updateBacSpeedSignal", self.setBaseVel)

func _ready():
	$AnimatedSprite2D.scale = Vector2(1, 1)
	Controller.appendBacInstances(self)
	$AnimatedSprite2D.play("Static")
	$Timer.wait_time = lifeTime
	$Timer.start()
func setBaseVel(vel: Vector2, _id):
	if id == _id:
		baseVel = vel
func _physics_process(delta):
	
	velocity = baseVel
	baseVel = Vector2(0,0)
	if Input.is_action_pressed("ui_up") : 
		velocity.y = -SPEED
	if Input.is_action_pressed("ui_left") : 
		velocity.x = -SPEED
	if Input.is_action_pressed("ui_down") : 
		velocity.y = SPEED
	if Input.is_action_pressed("ui_right") : 
		velocity.x = SPEED
	if life == 0 :
		death()
	move_and_slide()
func detect_distance() : 
	input_array = Array()
	if $Down.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Down.target_position)
		input_array.append(position.distance_to($Down.get_collider().position)/ray_size)
		input_array.append(class_dict[$Down.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)
	if $Right.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Right.target_position)
		input_array.append(position.distance_to($Right.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Right.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)
	if $Left.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Left.target_position)
		input_array.append(position.distance_to($Left.get_collider().position)/ray_size) 		
		input_array.append(class_dict[$Left.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)
	if $Up.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Up.target_position)
		input_array.append(position.distance_to($Up.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Up.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)
	if $Down_Right.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Down_Right.target_position)
		input_array.append(position.distance_to($Down_Right.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Down_Right.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)
	if $Down_Left.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Down_Left.target_position)
		input_array.append(position.distance_to($Down_Left.get_collider().position)/ray_size)
		input_array.append(class_dict[$Down_Left.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)
	if $Up_Right.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Up_Right.target_position)
		input_array.append(position.distance_to($Up_Right.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Up_Right.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)
	if $Up_Left.is_colliding() :
		var ray_size = Vector2(0,0).distance_to($Up_Left.target_position)
		input_array.append(position.distance_to($Up_Left.get_collider().position)/ray_size)		
		input_array.append(class_dict[$Up_Left.get_collider().get_groups()[0]])
	else:
		input_array.append(1)
		input_array.append(-1)

func _on_area_2d_body_entered(body):
	if body.get_groups()[0] == "2":
		body.points += 1
		life -= 1
		if life == 3:
			$AnimatedSprite2D.play("First_Dmg")
		if life == 1:
			$AnimatedSprite2D.play("Second_Dmg")
		if life == 0:
			body.points += 10
			body.increase_timer()
			death()

func _on_timer_timeout():
	death()
func death():
	points -= 100
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	self.queue_free()
func increase_timer(weight):
	$Timer.wait_time = $Timer.time_left + lifeTime/weight
	$Timer.start()
	if stattrak >= 2:
		points += 20
		$AnimatedSprite2D.scale = Vector2(0.36, 0.36)
		$AnimatedSprite2D.position.x -= 9
		SPEED = 0
		$AnimatedSprite2D.play("Mitosis")
		await $AnimatedSprite2D.animation_finished
		SPEED = 150
		$AnimatedSprite2D.scale = Vector2(1, 1)
		$AnimatedSprite2D.position.x += 9
		if life >= 4 :
			$AnimatedSprite2D.play("Static")
		if life <= 3:
			$AnimatedSprite2D.play("First_Dmg")
		if life == 1:
			$AnimatedSprite2D.play("Second_Dmg")
		Controller.spawnBac(Vector2(position.x - 20, position.y))
		
		stattrak = 0

