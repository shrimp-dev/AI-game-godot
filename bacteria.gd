extends CharacterBody2D


const SPEED = 150
var life = 5
var points = 0
var baseVel = Vector2(0,0)
var lifeTime = Controller.mac_life_time
const type = "bacteria"
func _ready():
	$AnimatedSprite2D.play("Static")
	$Timer.wait_time = lifeTime
	$Timer.start()
func _physics_process(delta):
	var baseVel = Vector2(0,0)
	velocity = baseVel
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
