#dependencies
require "csv"

def import
	filename = "pricing_sample.csv"
	@file = CSV.open(filename, {:headers => true, :header_converters => :symbol})
end

def discrepancies
	underscans = 0
	overscans = 0
	total_scans = 0
	nof = 0
	@file.each do |line|
		display_price = line[:display_price]
		scan_price = line[:scan_price]
		if display_price.to_f > scan_price.to_f and scan_price.to_f != 0.0
			underscans += 1
			total_scans += 1
			puts "---UNDERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		elsif display_price.to_f > scan_price.to_f and scan_price.to_f == 0.0
			nof += 1
			total_scans += 1
			puts "---NOF--- \n Display Price: #{display_price}"
		elsif
			display_price.to_f < scan_price.to_f 
			overscans += 1
			total_scans += 1
			puts "---OVERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		else
			total_scans += 1
		end
	end
	total_error = underscans + overscans + nof
	error_rate = ((total_error / total_scans) * 100).to_f
	puts "---SUMMARY--- \n Total Errors: #{total_error} \n Overscans: #{overscans} \n Underscans: #{underscans} \n NOF: #{nof} \n Scan Total: #{total_scans}"	
	puts "#{error_rate} %"
end


import
discrepancies

