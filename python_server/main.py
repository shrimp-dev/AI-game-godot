import socket
import time
import threading
from urllib import response
import numpy as np
from genetic.population import get_population
import json
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
        data = str(data)[2:]
        return data[data.find("{"):-1]
    except Exception as e:
        print(f"Error reading from client: {e}")
        return None

def write_to_client(message):
    global conn
    try:
        conn.sendall(message.encode())
    except Exception as e:
        print(f"Error writing to client: {e}")


def move_agent(agent_list):
    for id,agent in enumerate(agent_list):
        print("EAE")
        resp = ""
        # while True:
        while 0==len(resp):
            cmd = Command(agent.group, id, "sensors", 0, 0 )
            json_string = cmd.to_json()
            print(json_string)
            write_to_client(json_string)
            
            resp = str(read_from_client())
            print(len(resp))
            
        #     break
            # if resp[0] in ["K","J"]:
            #     break
        resp = eval(resp[:resp.find("}")+1])
        print(resp)
        
        if len(resp["sensors"])==0:
            continue
        # vel = agent.brain.brain_move(np.random.rand(8))
        vel = agent.brain.brain_move(resp["sensors"])
        print(vel)                
        cmd = Command(agent.group, id, "move", 2000*vel[0], 2000*vel[1] )
        json_string = cmd.to_json()
        print(json_string)
        write_to_client(json_string)

def run_server(host='127.0.0.1', port=8080):
    
    # bac_pop = get_population("bac",size=50)
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((host, port))
        s.listen()
        print(f"Server listening on {host}:{port}")

        localconn, addr = s.accept()
        global conn
        conn = localconn
        
        # # get base data
        # cmd = Command("main", 0, "get_base", 0, 0)
        # json_string = cmd.to_json()
        # print(json_string)
        # write_to_client(json_string)
        # print("main")
        # print(read_from_client())

        
            
        # get base data
        resp = ""
        while True:
            cmd = Command("main", 0, "get_base", 0, 0)
            json_string = cmd.to_json()
            print(json_string)
            write_to_client(json_string)
            print(resp :=  read_from_client())
            if resp :
                break
        resp = eval(resp[:resp.find("}")+1])
        macro_pop = get_population("macro",size=resp["macro_qnt"])
        bac_pop = get_population("bac",size=resp["bacteria_qnt"])
        # Create
        # for id,macro in enumerate(macro_pop):
        #     cmd = Command(macro.group, id, "create", 20, 20)
        #     json_string = cmd.to_json()
        #     print(json_string)
        #     write_to_client(json_string)
        print("EAE")
        while True:
            print("EAE")
            

            #move
            move_agent(macro_pop)
            move_agent(bac_pop)
        
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
    
    
    