require 'bundler/setup'
# require 'pry'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])
DB = PG.connect({:dbname => 'calendar_development'})

def main
  puts "Hey There!"
  loop do
    puts "To create a new event pres sht5i lik 1"
    puts "to list the sthi then press other ahsti lik 2"
    puts "wanna edit? three"
    puts " press clicky x to exit"
    shit = gets.chomp

    if shit == '1'
      add_event
    elsif shit == '2'
      list_events
    elsif shit == '3'
      edit_event
    elsif shit == 'x'
      exit
    else
      puts "wot m8?"
      main
    end
  end
end

def add_event
  puts "Enter event name."
  name = gets.chomp
  puts "Enter event location."
  location = gets.chomp
  @current_location = Location.create({name: location})
  puts "Enter event start date in the form mm/dd/yyyy"
  start_date = gets.chomp
  puts "Enter event end date in the form mm/dd/yyyy"
  end_date = gets.chomp
  @selected_event = Event.create({name: name, location_id: @current_location.id, start_date: start_date, end_date: end_date})
  list_events
end

def list_events
  puts "Here are all your events."
  Event.all.each_with_index do |event, i|
    puts (i+1).to_s + ". " + event.name
  end
end

def select_event
  list_events
  puts "select the number of the event:"
  i = gets.chomp.to_i
  @selected_event = Event.all[i-1]
end

def edit_event
  select_event
  puts "to delete 1"
  puts "to leave 2"
  shit = gets.chomp
  if shit == '1'
    @selected_event.destroy
  elsif shit == '2'
    main
  end
end


main
