#return uid in hexa str 
#creamos una clase que se llama Rfid 
class Rfid
#definimos un método que se llama read_uid 
	def read_uid
		#Hacemos un bucle infinito para reconocer tarjetas en el que el usuario
		#puede decidir si se continúa o no escaneando. 
		scan = 1 #esta variable indicará si se continúa o no escaneando 
		while scan do
			#El programa pide al usuario que escanee la tarjeta 
			puts "Please, swipe your card"
			userid = gets #gets returns a string 
			userid = userid.chomp #deletes from string the final 'enter'
			puts "Your ID in decimal base is: #{userid}"
			#converts string data to decimal integer 
			userid = userid.to_i
			#converts decimal to hexadecimal string
			userid = userid.to_s(16)
			#convierte minúsculas a mayúsculas 
			userid = userid.upcase
			#muestra uid por pantalla
			puts "Your UserID in hexadecimal is: #{userid}" 
			#pregunta al usuario si quiere volver a escanear 
			puts "Do you want to scann again? (y/n)"
			again = gets.chomp 
			if again=='n'
				scan = nil #pones la variable scan a false para que salga del bucle 
			end 
		end 
		#ruby returns the last evaluated expression, so 
		#we do not need to use 'return' here 
	end
end

#__FILE__ es una variable que contiene el nombre del archivo que 
#se está ejecutando en ese momento 
# $0 es el nombre del archivo principal para inicir el programa 
#Es una verificacion que dice 'si este es el archivo principal'
#Esto permite que puedas decidir si vas a usar un archivo como 
#biblioteca y no usar código en ese contexto, o si vas a usarlo 
#como ejecutable, que entonces ejecutará el código. 

#En este caso lo estamos usando como ejecutable. 
if __FILE__ == $0
#creamos un objeto de la clase Rfid llamado rf
rf = Rfid.new()
#llamamos al método read_uid sobre el objeto rf de la clase Rfid 
rf.read_uid
end 
