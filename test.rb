  def email(destinations)
	#destinations = "bla@sadfa.de;;asdf;drei";
    emailArray = destinations.split(/;+/)
    emailArray.each do |email|
	puts "email:" + email +"!END"
	if(email == nil)
		puts "nil email found"
	end
      if(!/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.match(email))
        puts "invalid " + email
#        record.errors[attribute] << "destination " + email + " is wrong"
      end
    end
  end
  
  email("bla@sadfa.de;asdf;drei")