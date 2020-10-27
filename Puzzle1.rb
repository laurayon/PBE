#return uid in hexa str 
class Rfid
#definimos un método que se llama read_uid 
  def read_uid
    userid = gets.chomp #string without enter
    #converts string to hexadecimal, caps string
    userid = userid.to_i.to_s(16).upcase
  end
end
