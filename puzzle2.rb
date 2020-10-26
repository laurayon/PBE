#we use puzzle1.rb as library, we use the order 'relative'
#because puzzle1 is in the same directory as puzzle2. 
require_relative 'Puzzle1.rb'
#we require the ruby GNOME2 library in order to work with graphic interfaces
require 'gtk3'

#we create a class puzzle2 that inherits from  Gtk::Window 
class Puzzle2 < Gtk::Window 
  #we define the class constructor 
  def initialize 
    #Variable inicialization, all instance variables
    super #inherit from superclass
    #css_provider can be used in gtk3 to store and change parameters
    #such as colour or font 
    @css_provider = Gtk::CssProvider.new
    #Create a grid to help widget placement 
    @grid = Gtk::Grid.new
    #Create a label 
    @label = Gtk::Label.new
    #Create 'Clear' button
    @cbutton = Gtk::Button.new(:label => "Clear")
    
    #Window definition
    #Set window tittle 
    set_title "Puzzle 2 Application"
    #Set window and border dimensions
    set_size_request(550,200) 
    set_border_width(10)
    #Set label dimensions
    @label.set_size_request(550,150) 
    #Set 'Clear' button dimensions 
    @cbutton.set_size_request(550,50) 
    #set screen position where window is displayed: center
    set_window_position(:center)
    #Add grid to window 
    add(@grid) 
    #Define initial disposition of button and label on the window
    #Attach label to grid: attach(child, column, row, width, height)
    @grid.attach @label, 0, 0, 1, 1
    #Define label characteristics by calling clearButton method 
    clearButton
    #Attach button to grid 
    @grid.attach @cbutton, 0, 1, 1, 1
    
    #Define window interactions 
    #Define that window closes when 'x' button is pressed 
    signal_connect "destroy" do Gtk.main_quit end 
    #Define consequence of clicking 'Clear' button 
    @cbutton.signal_connect "clicked" do clearButton end
    
    #Display window on screen
    show_all 
  end  
  
  
  #This function defines what happens when 'Clear' button is pressed 
  def clearButton
    #label restores message
    @label.set_text "Please, login with your university card"
    #label turns blue, text in white
    css_provider.load(:data => "label {background-color: blue;}\
                                label{color: white;}")
    @label.style_context.add_provider(css_provider, Gtk::StyleProvider::PRIORITY_USER)
  end 
  
  #This function defines what happens when UID is scanned 
  def show_uid(string)
    #label turns red  
    css_provider.load(:data => "label {background-color: red;}\
                                label{color: white;}")
    @label.style_context.add_provider(css_provider, Gtk::StyleProvider::PRIORITY_USER)
    #Message on label changes to 'uid: scanned UID'
    @label.set_text "uid: #{string}"
  end 
  
  #This function works for threads 
  def aux
  end 
end 

#MAIN PROGRAMM CODE
if __FILE__ == $0
  #Terminates the programm if the GUI cannot be initialized 
  Gtk.init 
  #we set a thread exception in case thread doesn't work 
  Thread.abort_on_exception = true; 
  #Create a new window
  w = Puzzle2.new()
  #Create object from Rfid class
  rf = Rfid.new()
  #Create a thread that allows reading from UID while graphic window is
  #asking for UID 
  t_read = Thread.new {
    while 1 do 
      w.aux(rf.read_uid())
      sleep 1 
    end
    }
  #Run main loop until main_quit is called 
  Gtk.main
end
