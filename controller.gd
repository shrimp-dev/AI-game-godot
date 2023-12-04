extends Node

signal spawnMacrofSignal()
signal spawnBacSignal()
signal updateMacroSpeedSignal()
signal writeToSocket()
signal startSocket()
signal getMacroSensorsSignal()
signal updateBacSpeedSignal()
signal getBacSensorsSignal()

var macro_qnt = 20 #int
var bacteria_qnt = 20
var cell_qnt = 30
var mac_life_time = 10000
var game_status = false
class Command:
	var actor #String 
	var id   #Int
	var commandStr #String 
	var x #int
	var y #int
	
	func _init(_actor: String = "", _id = 0,_command: String = "", _x: int = 0, _y: int = 0):
		actor = _actor
		commandStr = _command
		x = _x
		y = _y
		id = _id

	func to_dict() -> Dictionary:
		return {
			"actor": actor,
			"commandStr": commandStr,
			"x": x,
			"y": y,
			"id": id
		}

	func from_dict(data: Dictionary) -> void:
		actor = data.get("actor", "")
		commandStr = data.get("commandStr", "")
		x = data.get("x", 0)
		y = data.get("y", 0)
		id = data.get("id", 0)

	func to_json() -> String:
		return JSON.stringify(self.to_dict())

	func from_json(json_string: String) -> void:
		if json_string == "":
			return
		var data: Dictionary = JSON.parse_string(json_string)
		from_dict(data)
		
var macroInstances: Array = []
var bacInstances: Array = []
func appendMacroInstances(macrof):
	macroInstances.append(macrof)
func appendBacInstances(bac):
	bacInstances.append(bac)
func process_command(text):
	print(text)
	var cmdlist = text.split("/")
	for cmd in cmdlist:
		var new_cmd = Command.new()
		new_cmd.from_json(cmd)
		if new_cmd.actor == "macro":
			self.macrofageCommand(new_cmd)
		if new_cmd.actor == "bac":
			self.bacCommand(new_cmd)
		if new_cmd.actor == "main":
			self.mainCommand(new_cmd)
		
func start_socket():
	emit_signal("startSocket")
func spawnBac(pos):
	emit_signal("spawnBacSignal", pos, len(self.bacInstances))
func updateBacSpeed(vel: Vector2, id):
	emit_signal("updateBacSpeedSignal", vel, id)
func getBacSensors(id):
	emit_signal("getBacSensorsSignal",id)
	
func spawnMacrof(pos):
	emit_signal("spawnMacrofSignal", pos, len(self.macroInstances))

func updateMacroSpeed(vel: Vector2, id):
	emit_signal("updateMacroSpeedSignal", vel, id)
	
func getMacroSensors(id):
	emit_signal("getMacroSensorsSignal", id)
	
func bacCommand(command: Command):
	if command.commandStr == "create":
		self.spawnBac(Vector2(command.x, command.y))
	elif command.commandStr == "move":
		self.updateBacSpeed(Vector2(command.x, command.y), command.id)
	elif command.commandStr == "sensors":
		var text = {"id":command.id,
					"points":self.bacInstances[command.id].points,
					"sensors":self.bacInstances[command.id].input_array}
			
		self.write(str(text))
func macrofageCommand(command: Command):
	if command.commandStr == "create":
		self.spawnMacrof(Vector2(command.x, command.y))
	elif command.commandStr == "move":
		self.updateMacroSpeed(Vector2(command.x, command.y), command.id)
	elif command.commandStr == "sensors":
		var text = {"id":command.id,
					"points":self.macroInstances[command.id].points,
					"sensors":self.macroInstances[command.id].input_array}
			
		self.write(str(text))
		
		
func write(text):
	emit_signal("writeToSocket",text)
func mainCommand(command: Command):
	if command.commandStr == "get_base":
		var text = {"macro_qnt":macro_qnt,
				"bacteria_qnt":bacteria_qnt,
				"cell_qnt":cell_qnt,
				"mac_life_time":mac_life_time}
			
		self.write(str(text))
