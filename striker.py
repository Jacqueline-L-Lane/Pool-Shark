# Striker Code

import socket

HOST = '' # Server IP or Hostname  
PORT = 12345 # Must match the client port
SIZE = 1024

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print 'Socket created'

# Manage error exception:
try:
    s.bind((HOST, PORT))
except socket.error:
    print 'Bind failed '

s.listen(5)
print 'Socket awaiting messages'
(conn, addr) = s.accept()
print 'Connected'

# Await message from observer: 
while True:
    data = conn.recv(SIZE)
    print 'Sent a message back in response to: ' + data
    reply = ''

    # Process message:
    if data == 'Hello':
	reply = 'Hi'
    elif data == 'Do this':
        reply = 'Done'

    # End:
    elif data == 'quit':
        conn.send('Terminating')
	break
    else:
	reply = 'Unknown command'

    # Send reply
    conn.send(reply)
  
conn.close() # Close connections
