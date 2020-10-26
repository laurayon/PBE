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
