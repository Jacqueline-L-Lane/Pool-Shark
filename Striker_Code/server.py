import socket

HOST = '' # Server IP or Hostname   # 192.168.1.31
PORT = 12345 # Pick an open Port (1000+ recommended), must match the client port
SIZE = 1024

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print 'Socket created'

#managing error exception
try:
	s.bind((HOST, PORT))
except socket.error:
	print 'Bind failed '

s.listen(5)
print 'Socket awaiting messages'
(conn, addr) = s.accept()
print 'Connected'

# awaiting for message
while True:
	data = conn.recv(SIZE)
	print 'Sent a message back in response to: ' + data
	reply = ''

	# process message
	if data == 'Hello':
		reply = 'Hi, back!'
	elif data == 'This is important':
		reply = 'OK, I have done the important thing you have asked me!'

	#and so on and on until...
	elif data == 'quit':
		conn.send('Terminating')
		break
	else:
		reply = 'Unknown command'

	# Sending reply
	conn.send(reply)
conn.close() # Close connections

