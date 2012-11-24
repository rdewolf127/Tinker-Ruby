def prompt
	print ">>> "
end

def start()
	puts "Welcome to the audit test script."
	puts "What kind of audit would you like to do?"
	puts "Type 1 or Type 2?"

	audit_type = gets.chomp

	if audit_type == "Type 1"
		t1_audit()
	else
		t2_audit()
	end
end

def t1_audit()
	puts "Welcome to the Type 1 audit"

	questions = ["This is question 1.  y, n or na", "This is question 2.  y, n or na"]
	responses = []

	questions.each do |question|
		puts "#{question}"
		prompt; response = gets.chomp
		responses.push(response)
	end
	question_value(responses)
end

def question_value(responses)
	points_available = 0
	points_earned = 0

	responses.each do |response|
		if response == "y"
			points_available += 1
			points_earned += 1 
		elsif response  == "n"
			points_available += 1
		end
	end
	puts "Points Available: #{points_available}"
	puts "Points Earned: #{points_earned}"
end

start()


	



