extends ParallaxBackground
var rng = RandomNumberGenerator.new()
var scrolling_speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	var hemacias = $Red.get_children()
	var purple = $Purple.get_children()
	var white = $White.get_children()
	for i in hemacias :
		i.scale = Vector2(0.9, 0.9)
		i.speed_scale = rng.randf_range(6, 10.0)/10
		i.play("Move")
	for i in purple :
		i.speed_scale = rng.randf_range(2, 10.0)/10
		i.play("Move")
	for i in white :
		i.scale = Vector2(1.3, 1.3)
		i.speed_scale = rng.randf_range(5, 10.0)/10
		i.play("Move")
func _process(delta):
	scroll_offset.x -= scrolling_speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.

