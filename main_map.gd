extends Node2D
var cell = preload("res://cell_body.tscn")
var spawnLocs = Array()
var minDist = 18
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 100:
		var new_cell = cell.instantiate()
		new_cell.global_position = getNextSpawnLoc()
		new_cell.add_to_group("1")
		
		add_child(new_cell)
		
func getNextSpawnLoc():
	while true:
		var newLoc = Vector2(randi_range(20,get_viewport().get_visible_rect().size[0]-20),randi_range(20,get_viewport().get_visible_rect().size[1]-20))
		var tooClose = false
		for loc in spawnLocs:
			if newLoc.distance_to(loc) < minDist:
				tooClose = true;
				break;
		if !tooClose:
			spawnLocs.append(newLoc)
			return newLoc

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
