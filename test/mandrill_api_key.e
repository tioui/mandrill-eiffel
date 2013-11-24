note
	description : "Eiffel_MandrillApp application root class"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	MANDRILL_API_KEY

feature {NONE} -- The Key

	Api_key:READABLE_STRING_GENERAL
		once
			Result:="Your Key!"
		end
