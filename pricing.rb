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
		total_scans += 1
		if display_price.to_f > scan_price.to_f and scan_price.to_f != 0.0
			underscans += 1
			puts "---UNDERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		elsif display_price.to_f > scan_price.to_f and scan_price.to_f == 0.0
			nof += 1
			puts "---NOF--- \n Display Price: #{display_price}"
		elsif
			display_price.to_f < scan_price.to_f 
			overscans += 1
			puts "---OVERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		else
			#do nothing
		end
	end
	total_error = underscans + overscans + nof
	error_rate = sprintf('%.2f', (total_error.to_f / total_scans.to_f * 100.0)) + "%"
	underscan_rate = sprintf('%.2f', (underscans.to_f / total_scans.to_f * 100.0)) + "%"
	overscan_rate = sprintf('%.2f', (overscans.to_f / total_scans.to_f * 100.0)) + "%"
	nof_rate = sprintf('%.2f', (nof.to_f / total_scans.to_f * 100.0)) + "%"
	puts "---SUMMARY--- \n Total Errors: #{total_error}  Error Rate: #{error_rate} \n Overscans: #{overscans} Error Rate: #{overscan_rate} \n Underscans: #{underscans} Error Rate: #{underscan_rate} \n NOF: #{nof}  Error Rate: #{nof_rate}\n Scan Total: #{total_scans}"	
end


import
discrepancies

