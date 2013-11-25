note
	description: "Summary description for {MANDRILL_MESSAGE_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MANDRILL_MESSAGE_RESULT


create
	make,
	make_error

feature {NONE} -- Initialization

	make(a_result_code:NATURAL_16)
			-- Initialization for `Current'.
		do
			result_code:=a_result_code
			create {LINKED_LIST[TUPLE[email,status,id,reject_reason:READABLE_STRING_GENERAL]]} recipients.make
			error_code:=0
			error_status := ""
			error_name := ""
			error_message := ""
			has_error:=false
		end


	make_error(a_result_code,a_error_code:NATURAL_16;a_status, a_error_name, a_error_message:READABLE_STRING_GENERAL)
			-- Initialization for `Current'.
		do
			make(a_result_code)
			error_code:=a_error_code
			error_status:=a_status
			error_name:=a_error_name
			error_message:=a_error_message
			has_error:=true
		end

feature -- Access

	has_error:BOOLEAN

	result_code:NATURAL_16

	recipients:LIST[TUPLE[email,status,id,reject_reason:READABLE_STRING_GENERAL]]

	error_status:READABLE_STRING_GENERAL

	error_code:NATURAL_16

	error_name:READABLE_STRING_GENERAL

	error_message:READABLE_STRING_GENERAL

end
