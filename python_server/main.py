import socket
import time
import threading

conn = {}

import json

class Command:
    def __init__(self, actor="", id=0, commandStr="", x=0, y=0):
        self.actor = actor
        self.id = id
        self.commandStr = commandStr
        self.x = x
        self.y = y

    def to_dict(self):
        return {
            "actor": self.actor,
            "id": self.id,
            "commandStr": self.commandStr,
            "x": self.x,
            "y": self.y
        }

    def from_dict(self, data):
        self.actor = data.get("actor", "")
        self.id = data.get("id", 0)
        self.commandStr = data.get("commandStr", "")
        self.x = data.get("x", 0)
        self.y = data.get("y", 0)

    def to_json(self):
        return json.dumps(self.to_dict()) + "/"

    def from_json(self, json_string):
        data = json.loads(json_string)
        self.from_dict(data)

def read_from_client():
    global conn
    try:
        data = conn.recv(1024)
        if not data:
            return None
        return data.decode()
    except Exception as e:
        print(f"Error reading from client: {e}")
        return None

def write_to_client(message):
    global conn
    try:
        conn.sendall(message.encode())
    except Exception as e:
        print(f"Error writing to client: {e}")

def run_server(host='127.0.0.1', port=8080):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((host, port))
        while True:
            s.listen()
            print(f"Server listening on {host}:{port}")

            localconn, addr = s.accept()
            global conn
            conn = localconn

            cmd = Command("macro", 0, "create", 20, 20)
            json_string = cmd.to_json()
            print(json_string)
            write_to_client(json_string)

            cmd = Command("macro", 0, "move", 20, 20)
            json_string = cmd.to_json()
            print(json_string)

            write_to_client(json_string)
        
                # Here you can add logic to process the data and send a response
                # For example:
                # response = "Received: " + data.decode()
                # conn.sendall(response.encode())

if __name__ == "__main__":
# Run the server
    server_thread = threading.Thread(target=run_server)
    server_thread.start()
    while True:
        pass
    
    
    