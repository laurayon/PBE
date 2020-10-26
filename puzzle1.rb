#return uid in hexa str 
#creamos una clase que se llama Rfid 
class Rfid
#definimos un método que se llama read_uid 
  def read_uid
    userid = gets.chomp #string without enter
    #converts string data to decimal integer 
    userid = userid.to_i
    #converts decimal to hexadecimal string
    userid = userid.to_s(16)
    #converts to caps 
    userid = userid.upcase
    #ruby returns the last evaluated expression, so 
    #we do not need to use 'return' here 
  end
end

#En este caso lo estamos usando como ejecutable. 
if __FILE__ == $0
#creamos un objeto de la clase Rfid llamado rf
rf = Rfid.new()
#llamamos al método read_uid sobre el objeto rf de la clase Rfid, guardamos el output en uid 
uid = rf.read_uid
#muestra uid por pantalla 
puts uid
end 
