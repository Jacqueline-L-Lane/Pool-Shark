import socket

HOST = '192.168.1.71' # Enter IP or Hostname of your server
PORT = 12345 # Pick an open Port (1000+ recommended), must match the server port
SIZE = 1024

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST,PORT))

#Loop awaiting for input
while True:
	command = raw_input('Enter your command: ')
	s.send(command)
	reply = s.recv(SIZE)
	if reply == 'Terminate':
		break
	print reply
	#s.close()
