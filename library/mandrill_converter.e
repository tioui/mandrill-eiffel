note
	description: "Summary description for {MANDRILL_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MANDRILL_CONVERTER

inherit
	SHARED_EJSON
	MANDRILL_CONSTANTS

feature -- Conversion

	to_json(a_object: MANDRILL_ANY): JSON_OBJECT
		do
			create Result.make
            Result.put (json.value (a_object.api_key), Api_key_key)
		end

	from_json(a_json:JSON_OBJECT):detachable MANDRILL_ANY
		do
			Result := Void
		end



end
