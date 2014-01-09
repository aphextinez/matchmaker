from twisted.internet.protocol import Factory, Protocol
from twisted.internet import reactor

import sqlite3 as lite

class MatchMaker(Protocol):
	def connectionMade(self):
		self.factory.clients.append(self)
		print "clients are ", self.factory.clients

	def connectionLost (self, reason):
		self.factory.clients.remove(self)

	def dataReceived(self, data):
		a = data.split(':')
		args = a[1].split(' ')
		print "Type of msg ", data
        
		if len(a) > 1:
			command = a[0]


			msg = ""
			if command == "login":
				print "Login"
				cursor.execute("SELECT password FROM userTable WHERE email=:email", {"email": args[0]})
				db.commit()
				passw = cursor.fetchone()

			elif (command == "form"):
				print "Form ", data
			elif command == "createLogin":
				print "Create login"

                if (args[5] == "0"):
                    gender = "Male"
                else:
                    gender = "Female"

                with db:
                    # Execute the SQL command
                    cursor.execute("INSERT INTO userTable VALUES (?, ?, ?, ? ,?, ? , ?, ?, ?, ?, ?)", (args[0], int(args[1]), args[2], args[3], args[4], gender, -1, -1, -1, -1, -1))

                    #except:
                    #print "Error: unable to insert data"

                for c in self.factory.clients:
                    c.response(msg)


	def response(self, message):
		self.transport.write(message + '\n')

# Open database connection
db = lite.connect('users.db')

# prepare a cursor object using cursor() method
cursor = db.cursor()

factory = Factory()
factory.protocol = MatchMaker
factory.clients = []
reactor.listenTCP(80, factory)
print "Machmaker server started"
reactor.run()

# disconnect from server
db.close()


#           cursor.execute("SELECT password FROM userTable WHERE email=:email", {"email": args[0]})
#           db.commit()
#           passw = cursor.fetchone()
#           if (passw == args[1]):
#               print "Password match"
#           else:
#               print "Password dont match"

