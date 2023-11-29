extends Node

signal spawnMacrofSignal()
signal spawnBacSignal()
signal updateMacroSpeedSignal()

var macro_qnt = 10 #int
var bacteria_qnt = 15
var cell_qnt = 80
var mac_life_time = 10
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
		

func spawnBac(pos):
	emit_signal("spawnBacSignal", pos, len(self.bacInstances))
	
func spawnMacrof(pos):
	emit_signal("spawnMacrofSignal", pos, len(self.macroInstances))

func updateMacroSpeed(vel: Vector2, id):
	emit_signal("updateMacroSpeedSignal", vel, id)
	
func bacCommand(command: Command):
	if command.commandStr == "create":
		self.spawnMacrof(Vector2(command.x, command.y))
	elif command.commandStr == "move":
		self.updateMacroSpeed(Vector2(command.x, command.y), command.id)
func macrofageCommand(command: Command):
	if command.commandStr == "create":
		self.spawnMacrof(Vector2(command.x, command.y))
	elif command.commandStr == "move":
		self.updateMacroSpeed(Vector2(command.x, command.y), command.id)
	
