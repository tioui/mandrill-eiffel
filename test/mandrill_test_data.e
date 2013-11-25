note
	description : "Eiffel_MandrillApp application root class"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	MANDRILL_TEST_DATA

feature {NONE} -- The Data

	Api_key:READABLE_STRING_GENERAL
		once
			Result:="Your Key!"
		end

	From_name:READABLE_STRING_GENERAL
		once
			Result:="The Name"
		end

	From_email:READABLE_STRING_GENERAL
		once
			Result:="email@domain.com"
		end

	To_name:READABLE_STRING_GENERAL
		once
			Result:="The Recipient"
		end

	To_email:READABLE_STRING_GENERAL
		once
			Result:="email@to_send.net"
		end

end
