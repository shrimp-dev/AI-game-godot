extends ParallaxBackground

var scrolling_speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	var hemacias = $Red.get_children()
	var purple = $Purple.get_children()
	for i in hemacias :
		i.play("Move")
	for i in purple :
		i.play("Move")
func _process(delta):
	scroll_offset.x -= scrolling_speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.

