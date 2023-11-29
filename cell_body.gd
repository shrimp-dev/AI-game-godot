extends CharacterBody2D

const type = "cell"
var life = 10

func _on_area_2d_body_entered(body):
	if body.get_groups()[0] == "3":
		
		life -= 1
		body.points += 1
		body.increase_timer(10)
		if life == 8:
			$Cell.texture = load("res://assets/Cell/Cell3.png")
		if life == 6:
			$Cell.texture =  load("res://assets/Cell/Cell4.png")
		if life == 4:
			$Cell.texture =  load("res://assets/Cell/Cell5.png")
		if life == 2:
			$Cell.texture =  load("res://assets/Cell/Cell6.png")
		if life == 1:
			$Cell.texture =  load("res://assets/Cell/Cell7.png")
		
		if life == 0:
			body.points += 10
			body.stattrak += 1
			body.increase_timer(2)
			death()

func death():
	self.queue_free()
