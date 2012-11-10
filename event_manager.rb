#Dependencies
require "csv"

# Class Definition
class EventManager
	INVALID_ZIPCODE = "00000"
	INVALID_PHONENUMBER = "0000000000"
	def Initialize
		puts "Event Manager Inititalized."
		filename = "event_attendees.csv"
		@file = CSV.open(filename, {:headers => true, :header_converters => :symbol})
	end
	def print_names
		@file.each do |line|
			puts line.inspect
			#puts line[2] + " " + line[3]
		end
	end
	def clean_number(original)
		@file.each do |line|
			first_number = line[:homephone]
			if first_number.length == 10
				#do nothing
			elsif first_number.length == 11
				if first_number.start_with?("1")
					first_number = first_number[1..-1]
				else
					first_number = INVALID_PHONENUMBER
				end
			else
				first_number = INVALID_PHONENUMBER
			end
			second_number = first_number.delete("-" + "." + ")" + "(" + " ")
			return second_number
		end
	end

	def print_numbers
		@file.each do |line|
			clean_number = clean_number(line[:homephone])
			puts clean_number
		end
	end

	def clean_zipcode(original)
		if original.nil?
			new = INVALID_ZIPCODE
		elsif original.length < 5
			new = "0#{original}"
		else
			#do nothing
		end
		return new
	end

	def print_zipcodes
		@file.each do |line|
			clean_zipcode = clean_zipcode(line[:zipcode])
			puts clean_zipcode
		end
	end

	def output_data
		output = CSV.open("event_attendees_clean.csv", "w")
		@file.each do |line|
			output << line
		end
	end
end

#Script
manager = EventManager.new
manager.Initialize
manager.print_names
manager.print_numbers
manager.print_zipcodes
manager.output_data