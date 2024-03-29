require 'pry'
require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])
DB = PG.connect({:dbname => 'calendar_development'})

def main
  puts "Hey There!"
  loop do
    puts "To create a new event press 1"
    puts "to list press 2"
    puts "wanna edit? 3"
    puts "list upcoming events 4"
    puts "press clicky x to exit"
    st = gets.chomp

    if st == '1'
      add_event
    elsif st == '2'
      list_events
    elsif st == '3'
      edit_event
    elsif st == '4'
      list_future_events
    elsif st == 'x'
      exit
    else
      puts "wot m8?"
      main
    end
  end
end

def list_future_events
  Event.future_events.each_with_index do |event, i|
    # binding.pry
    puts (i + 1).to_s + ". " + event.name
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
  puts "to change name 3"
  puts "to change location 4"
  puts "to change start date 5"
  puts "to change end date 6"
  shit = gets.chomp
  if shit == '1'
    @selected_event.destroy
  elsif shit == '2'
    main
  elsif shit == '3'
    puts 'enter name.'
    name = gets.chomp
    @selected_event.name = name
    @selected_event.save
  elsif shit == '4'
    puts 'enter location'
    location = gets.chomp
    location_event = Location.create({ name: location})
    @selected_event.location_id = location_event.id
    @selected_event.save
  elsif shit == '5'
    puts 'enter new start date'
    start = gets.chomp
    @selected_event.start_date = start
    @selected_event.save
  elsif shit == '6'
    puts 'enter new end date'
    end_date = gets.chomp
    @selected_event.end_date = end_date
    @selected_event.save
  end
end


main
