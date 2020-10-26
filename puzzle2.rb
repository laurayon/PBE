#we use puzzle1.rb as library, we use the order 'relative'
#because puzzle1 is in the same directory as puzzle2. 
require_relative 'puzzle1.rb'
#we require the ruby GNOME2 library in order to work with graphic interfaces
require 'gtk3'
#we create a class puzzle2 that inherits from  Gtk::Window 
class puzzle2 < Gtk::Window 
  #we define the class constructor 
  def initialize 
    #Variable inicialization, all instance variables
    super #inherit from superclass
    #css_provider is needed in gtk3 to change parameters
    #such as colour or font 
    @css_provider = Gtk::CssProvider.new
    #Create a grid to help widget placement 
    @grid = Gtk::Grid.new
    #Create a label with default message  
    @label = Gtk::Label.new "Please, login with your university card"
    #Create 'Clear' button
    @cbutton = Gtk::Button.new(:label => "Clear")
    
    #Window definition
    #Set window tittle 
    set_title "Puzzle 2 Application"
    #Set window and border dimensions
    set_size_request(550,200) 
    set_border_width(10)
    #Set label dimensions
    label.set_size_request(550,150) 
    #Set 'Clear' button dimensions 
    cbutton.set_size_request(550,50) 
    #set screen position where window is displayed: center
    set_window_position(:center)
    #Define initial disposition of button and label on the window
    #Attach label to grid
    #attach(child, left(column), top(row), width, height)
    grid.attach label, 0, 0, 1, 1
    #Attach button to grid 
    grid.attach cbutton, 0, 1, 1, 1
    
    #Define window interactions 
    #Define that window closes when 'x' button is pressed 
    signal_connect "destroy" do Gtk.main_quit end 
    #Define consequence of clicking 'Clear' button 
    cbutton.signal_connect "clicked" do clearButton end
    
  end  
  
  
  
  
  #This function defines what happens when 'Clear' button is pressed 
  def clearButton
    #label restores message
    label.set_label 
    #label turns blue 
    css_provider.load(data: "label{background-color: blue;}\
                         label{color: white;}\
                         label{background-color: brown;}"
                 )
    #Message on label changes to 'Please, login with your university card'
  end 
  
  #This function defines what happens when UID is scanned 
  def show_uid
    #label turns red  
    #Message on label changes to 'uid: scanned UID'
  end 
  
  #This function works for threads 
  def aux
  end 
end 






















#Terminates the programm if the GUI cannot be initialized 
Gtk.init 
# Create a new window
window = Gtk::Window.new Puzzle 2 Application 
label = Gtk::Label.new You are a trout!
window.add label
window.signal_connect(destroy) { Gtk.main_quit }
window.show_all
Gtk.main

#we set a thread exception in case thread doesn't work 
Thread.abort_on_exception = true; 
#start a thread for reading the uid 
t_read = Thread.new {}
//Ruby doesn't wait for threads to finish 

t.join //to make thre thread finish 
