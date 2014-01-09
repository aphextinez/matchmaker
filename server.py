from twisted.internet.protocol import Factory, Protocol
from twisted.internet import reactor

import sqlite3 as lite
import unicodedata

global name

class MatchMaker(Protocol):
    
	def connectionMade(self):
		self.factory.clients.append(self)
		print "clients are ", self.factory.clients

	def connectionLost (self, reason):
		self.factory.clients.remove(self)

	def dataReceived(self, data):
		global name
		name = "Default"
		a = data.split(':')
		args = a[1].split(' ')
		print "Type of msg ", data
	        if len(a) > 1:
			command = a[0]
			msg = ""
	                print "Command ", command
                    
			# Login command
			if command == "Login":
				if (args[0] == ""):
					msg = "Enter email."
					
				elif (args[1] == ""):
					msg = "Enter password."
					
				else:
					self.login = args[0]
					print "Login"
					name = args[0] 
					cursor.execute("SELECT password FROM userTable WHERE email=:email", {"email": args[0]})
					db.commit()
					passw = cursor.fetchone()
					print "Password input ", args[1]
					print "Password db ", passw
					if (passw[0] == args[1]):
						print "Password match"
						msg = "Login : " + name + " has joined!"
						match = ""
						minSum = 100
						cursor.execute("SELECT q1, q2, q3, q4, q5 from userTable where email =:email",{"email":args[0]})
						data = cursor.fetchone()
						q1 = data[0]
						q2 = data[1]
						q3 = data[2]
						q4 = data[3]
						q5 = data[4]
						cursor.execute('SELECT email, q1, q2, q3, q4, q5 FROM userTable')

						for i in cursor.fetchall():
							total = abs(q1-i[1]) + abs(q2-i[2]) + abs(q3-i[3]) + abs(q4-i[4]) + abs(q5-i[5])
							if (total < minSum):
								minSum = total
								match = i[0]

						print "Match is ", match
						match = unicodedata.normalize('NFKD', match).encode('ascii','ignore')
						msg = match



					elif (passw[0] != None):
						print "Password dont match"
						msg = "Login : Password invalid"
					else: 
						msg = "Login : User not found!"


			# Form command
			elif (command == "Form"):
				print "Form ", data
           			with db:
                        
	        	                print "Name = ", name
        	        	        print "ARGS = ", args[0], args[1], args[2], args[3], args[4]
					#Execute the SQL command
					cursor.execute("UPDATE userTable SET q1=?, q2=?, q3=?, q4=?, q5=? WHERE name=?", (int (args[0]), int (args[1]), int(args[2]), int(args[3]), int(args[4]), name))
                			db.commit()
                                	match = ""
                                        minSum = 100
					q1 = int (args[0])
					q2 = int (args[1])
					q3 = int (args[2])
					q4 = int (args[3])
					q5 = int (args[4])
					cursor.execute('SELECT email, q1, q2, q3, q4, q5 FROM userTable')

					for i in cursor.fetchall():
						total = abs(q1-i[1]) + abs(q2-i[2]) + abs(q3-i[3]) + abs(q4-i[4]) + abs(q5-i[5])
						if (total < minSum):
							minSum = total
							match = i[0]

					print "Match is ", match
					match = unicodedata.normalize('NFKD', match).encode('ascii','ignore')
					msg = match


			# Create Login
			elif command == "createLogin":

				print "Create login"
                    
                    		name = args[0]

                		if (args[5] == "0"):
					gender = "Male"
               		 	else:
					gender = "Female"

                		with db:
                    			# Execute the SQL command
                    			cursor.execute("INSERT INTO userTable VALUES (?, ?, ?, ? ,?, ? , ?, ?, ?, ?, ?)", (args[0], int(args[1]), args[2], args[3], args[4], gender, -1, -1, -1, -1, -1))

                    		#except:
                    		#print "Error: unable to insert data"

			else:
				return
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
reactor.listenTCP(5555, factory)
print "Machmaker server started"
reactor.run()

# disconnect from server
db.close()


