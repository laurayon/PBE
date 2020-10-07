#we use puzzle1.rb as library, we use the order 'relative'
#because puzzle1 is in the same directory as puzzle2. 
require_relative 'puzzle1.rb'
#in order to install ruby GNOME2: 
#sudo apt-get update
#sudo apt-get install ruby-gnome2
#we require the ruby GNOME2 library in order to work with graphic interfaces
require 'gtk2'
# Create a new window
window = Gtk::Window.new( Gtk::Window::TOPLEVEL )
