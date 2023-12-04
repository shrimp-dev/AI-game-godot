class_name Core
extends Node


# What region will we be connecting to?
var region: String = "US"

# Dictionary of server regions containing their matching ip/port
var _server_dict: Dictionary = {
	"Local": ["127.0.0.1", 8080],
	"US": ["127.0.0.1", 8080]
}

var connection
var connected = false
func _init():
	Controller.connect("writeToSocket",self.write)
	Controller.connect("startSocket",self.start_socket)

func start_socket():
	var ip = _server_dict[region][0]
	var port = _server_dict[region][1]
	
	connection = StreamPeerTCP.new()
	connection.connect_to_host(ip, port)
	
	connection.poll()
	
	if connection.get_status() == connection.STATUS_CONNECTED:
		print("Successfully connected to the server")
		connected = true
	elif connection.get_status() == StreamPeerTCP.STATUS_CONNECTING:
		print("Trying to connect to " + ip + " : " + str(port))
	elif connection.get_status() == connection.STATUS_NONE or connection.get_status() == StreamPeerTCP.STATUS_ERROR:
		print("Error connecting to " + ip + " : " + str(port))

func _process( delta ):
	if connection==null:
		return
	var ip = _server_dict[region][0]
	var port = _server_dict[region][1]
	
	connection.poll()

	if !connected:
		if connection.get_status() == connection.STATUS_CONNECTED:
			print("Process connected to " + ip + " : " + str(port))
			connected = true
			return
	
	if connection.get_status() == connection.STATUS_NONE or connection.get_status() == connection.STATUS_ERROR:
		print("Server disconnected?")
		connected = false
		set_process(false)
		return
	
	var available_bytes: int = connection.get_available_bytes()
	if available_bytes > 0:
		print("available bytes: ", available_bytes)
		var data: Array = connection.get_partial_data(available_bytes)
		# Check for read error.
		if data[0] != OK:
			print("Error getting data from stream: ", data[0])
		else:
			print("Got Data: ")
			Controller.process_command(data[1].get_string_from_utf8())
			
func write(text):
	var ip = _server_dict[region][0]
	var port = _server_dict[region][1]
	
	connection.poll()

	if !connected:
		if connection.get_status() == connection.STATUS_CONNECTED:
			print("Process connected to " + ip + " : " + str(port))
			connected = true
			return
	
	if connection.get_status() == connection.STATUS_NONE or connection.get_status() == connection.STATUS_ERROR:
		print("Server disconnected?")
		connected = false
		set_process(false)
		return
		
	connection.put_utf8_string(text)
	

