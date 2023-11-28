import socket

def test_connection(host='127.0.0.1', port=8080):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        try:
            s.connect((host, port))
            print("Successfully connected to the server.")
            s.close()
        except Exception as e:
            print(f"Connection failed: {e}")

test_connection()