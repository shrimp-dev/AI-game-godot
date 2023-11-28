extends Node2D


func _ready():
	pass # Replace with function body.


func _on_play_pressed():
	get_tree().change_scene_to_file("res://main_map.tscn")
	print(Controller.macro_qnt)

func _on_leave_pressed():
	get_tree().quit()

func _on_macro_text_changed():
	Controller.macro_qnt = int($Macro.text)

func _on_cells_text_changed():
	Controller.cell_qnt = int($Cells.text)

func _on_bacteria_text_changed():
	Controller.bacteria_qnt = int($Bacteria.text)

func _on_life_time_text_changed():
	Controller.mac_life_time = int($LifeTime.text)
