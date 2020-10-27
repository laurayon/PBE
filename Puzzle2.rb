#we use puzzle1.rb as library, we use the order 'relative'
#because puzzle1 is in the same directory as puzzle2. 
require_relative 'Puzzle1.rb'
#we require the ruby GNOME2 library in order to work with graphic interfaces
require 'gtk3'

#we create a class puzzle2 that inherits from  Gtk::Application
#it will create an Application that will gererate a window
class Puzzle2 < Gtk::Application 
  #we define the class constructor 
  def initialize 
    super("puzzle2.application", :flags_none) 
    #Define activate event for application window
    signal_connect "activate" do |application|
      #Define Application elements 
      #Create a window 
      w = Gtk::ApplicationWindow.new(application)
      #Create a grid to help widget placement on window
      grid = Gtk::Grid.new
      #Create 'Clear button'
      cbutton = Gtk::Button.new(:label => "Clear")
      #Create a label 
      @label = Gtk::Label.new
      #Create css_provider (used in gtk3 to store and change parameters
      #such as colour or font)  
      @css_provider = Gtk::CssProvider.new
      
      #Characterize elements 
      #Set window tittle 
      w.set_title "Puzzle 2 Application"
      #Set window and border dimensions
      w.set_size_request(550,200) 
      w.set_border_width(10)
      #set screen position where window is displayed: center
      w.set_window_position(:center)
      #Set label dimensions
      @label.set_size_request(550,150) 
      #Set 'Clear' button dimensions 
      cbutton.set_size_request(550,50) 
      
      #Define window interactions 
      #Define consequence of clicking 'Clear' button 
      cbutton.signal_connect ("clicked") {clearButton}
      
      #Aesthetically characterize window
      #Add grid to window 
      w.add(grid)
      #Define initial disposition of button and label on the window
      #Attach label to grid: grid cell (0,0), no spanning 
      grid.attach(@label, 0, 0, 1, 1) 
      #Define label characteristics by calling clearButton method 
      clearButton
      #Attach button to grid : grid cell (0,1), no spanning 
      grid.attach(cbutton, 0, 1, 1, 1)
      
      #Show all widgets on window 
      w.show_all
    end
  end        
    
  #This function defines what happens when 'Clear' button is pressed 
  def clearButton
    #label restores message
    @label.set_text "Please, login with your university card"
    #label turns blue, text in white
    @css_provider.load(:data => "label {background-color: blue;}\
                                label{color: white;}")
    @label.style_context.add_provider(@css_provider, Gtk::StyleProvider::PRIORITY_USER)
  end 
  
  #This function defines what happens when UID is scanned 
  def show_uid(string)
    #label turns red  
    @css_provider.load(:data => "label {background-color: red;}\
                                label{color: white;}")
    @label.style_context.add_provider(@css_provider, Gtk::StyleProvider::PRIORITY_USER)
    #Message on label changes to 'uid: scanned UID'
    @label.set_text "uid: #{string}"
    #Tell Glib to stop calling show_uid because it has already been called 
    return false 
  end 
  
  #Aux receives what read_uid has scanned, and calls show_uid when there are no other tasks
  #being performed at the moment. 
  def aux (string)
    #GLib:: Idle.add Adds a block to be called (show_uid) whenever there are no higher priority
    #events pending to the default main loop. The block is given the default idle 
    #priority, GLib::PRIORITY_DEFAULT_IDLE. 
     GLib::Idle.add{show_uid(string)}
    #If the block returns FALSE (which we do once it has been called once) it is 
    #automatically removed from the list of event sources and will not be called again.
  end 
end 

#MAIN PROGRAMM CODE
#It consists of 2 threads, one that launches the GUI, and another one that 
#asks the RF ID reader if it has scanned a card 

if __FILE__ == $0
  #we set a thread exception in case thread doesn't work 
  Thread.abort_on_exception = true; 
  #Create a new application 
  app = Puzzle2.new()
  #Create object from Rfid class
  rf = Rfid.new()
  #Create the thread that allows reading from UID while graphic window is
  #asking for UID 
  t_read = Thread.new {
    #loop that asks for scanned cards 
    while 1 do 
      app.aux(rf.read_uid())
      sleep 2 
    end
    }
  #launch application
  status = app.run([$0] + ARGV)
  puts status
end

