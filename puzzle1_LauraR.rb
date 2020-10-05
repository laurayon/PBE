#return uid in hexa str 
require 'nfc' 

#creamos una clase que se llama Rfid 
class Rfid
#definimos un método que se llama read_uid 
	def read_uid
		# Create a new context
		ctx = NFC::Context.new
		# Abrimos el primer puerto USB disponible (en nuestro caso el RFID)
		#usamos nil para indicar que el puerto de entrada esta en 'empty' 
		#vendría siendo un estado inicial, sin que hayamos pasado ninguna
		#tarjeta 
		treadr = ctx.open nil
		# Hacemos un bucle infinito para reconocer non-stop las tarjetas
		loop do
			#select bloquea hasta que se escanea una tarjeta 
			#luego recibe data del rfid que guarda en userid 
			userid = treadr.select
			userid = gets #gets returns a string 
			userid = userid.chomp #deletes from string the final 'enter'
			#converts string data to decimal integer 
			userid = userid.to_i
			#converts decimal to hexadecimal string
			userid = userid.to_s(16)
			#convierte minúsculas en mayúsculas 
			userid = userid.upcase
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
#metemos en la variable uid el output del método read_uid sobre 
#el objeto rf de a clase Rfid 
uid = rf.read_uid
#mostramos uid por pantalla
puts uid 
end 
