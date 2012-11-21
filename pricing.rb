#dependencies
require "csv"

def import
	filename = "pricing_sample.csv"
	@file = CSV.open(filename, {:headers => true, :header_converters => :symbol})
end

def discrepancies
	total_scans = 0
	underscan_error_count = 0
	overscan_error_count = 0
	underscan_error_sum = 0
	overscan_error_sum = 0
	nof_error_count = 0
	nof_error_sum = 0
	@file.each do |line|
		display_price = line[:display_price]
		scan_price = line[:scan_price]
		total_scans += 1
		error_sum_calc = display_price.to_f - scan_price.to_f
		if display_price.to_f > scan_price.to_f and scan_price.to_f != 0.0
			underscan_error_count += 1
			underscan_error_sum += error_sum_calc.abs
			#puts "---UNDERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		elsif display_price.to_f > scan_price.to_f and scan_price.to_f == 0.0
			nof_error_count += 1
			nof_error_sum += display_price.to_f
			#puts "---NOF--- \n Display Price: #{display_price}"
		elsif
			display_price.to_f < scan_price.to_f 
			overscan_error_count += 1
			overscan_error_sum += error_sum_calc.abs
			#puts "---OVERSCAN--- \n Display Price: #{display_price} \n Scan Price: #{scan_price}"
		end
	end
	total_error = underscan_error_count + overscan_error_count + nof_error_count
	error_rate = sprintf('%.2f', (total_error.to_f / total_scans.to_f * 100.0)) + "%"
	underscan_rate = sprintf('%.2f', (underscan_error_count.to_f / total_scans.to_f * 100.0)) + "%"
	overscan_rate = sprintf('%.2f', (overscan_error_count.to_f / total_scans.to_f * 100.0)) + "%"
	nof_rate = sprintf('%.2f', (nof_error_count.to_f / total_scans.to_f * 100.0)) + "%"
	average_underscan = "$" + sprintf('%.2f', (underscan_error_sum.to_f / underscan_error_count))
	average_overscan = "$" + sprintf('%.2f', (overscan_error_sum.to_f / overscan_error_count))
	average_nof = "$" + sprintf('%.2f', (nof_error_sum.to_f / nof_error_count))
	puts "\n ---SUMMARY--- \n\n Scan Total: #{total_scans} \n\n Total Errors: #{total_error}   | #{error_rate} \n\n Overscans: #{overscan_error_count}       | #{overscan_rate}   | Avg: #{average_overscan}\n Underscans: #{underscan_error_count}      | #{underscan_rate}   | Avg: #{average_underscan}\n NOF: #{nof_error_count}             | #{nof_rate}   | Avg: #{average_nof}\n\n"	
end


import
discrepancies

