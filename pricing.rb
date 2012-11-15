#dependencies
require "csv"

def import
	filename = "pricing_sample.csv"
	@file = CSV.open(filename, {:headers => true, :header_converters => :symbol})
end

def discrepancies_2
	underscans = 0
	overscans = 0
	total_scans = 0
	@file.each do |line|
		display_price = line[:display_price]
		scan_price = line[:scan_price]
		if display_price.to_f > scan_price.to_f
			underscans += 1
			total_scans += 1
			puts "---UNDERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		elsif
			display_price.to_f < scan_price.to_f
			overscans += 1
			total_scans += 1
			puts "---OVERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		else 
			total_scans += 1
		end
	puts "---SUMMARY--- \n Overscan Subtotal: #{overscans} \n Underscan Subtotal: #{underscans} \n Scan Subtotal: #{total_scans}"	
	end
end

def discrepancies
	@file.each do |line|
		display_price = line[:display_price]
		scan_price = line[:scan_price]
		error = display_price.to_f - scan_price.to_f
		if display_price.to_f > scan_price.to_f
			puts "---UNDERSCAN--- \n Display price: $#{display_price}, Scan price: $#{scan_price}, Error: $#{error}"
		elsif display_price.to_f < scan_price.to_f
			puts "---OVERSCAN--- \n Display price: $#{display_price}, Scan price: $#{scan_price}, Error: $#{error}"
		else
			#do nothing
		end
	end
end

import
#discrepancies
discrepancies_2
