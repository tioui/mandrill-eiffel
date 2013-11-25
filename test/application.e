note
	description : "Eiffel_MandrillApp application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS
	MANDRILL_TEST_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_message:MANDRILL_MESSAGE
			l_variables_recipients:ARRAYED_LIST[TUPLE[name,value:READABLE_STRING_GENERAL]]
		do
			create l_message.make (Api_key)
			l_message.text_message:="Example text content"
			l_message.html_message:="<p>Example HTML content</p>"
			l_message.subject:="A subject"
			l_message.from_email:=From_email
			l_message.from_name:=From_name
			l_message.add_recipient (To_name, To_email, false, false)
			l_message.send
			if attached l_message.request_result as la_result then
				if la_result.has_error then
					print("An error occured:%N")
					print("    Status: " + la_result.error_status + "%N")
					print("    Code: " + la_result.error_code.out + "%N")
					print("    Name: " + la_result.error_name + "%N")
					print("    Message: " + la_result.error_message + "%N")
				else
					print("The message as been send:%N")
					across la_result.recipients as la_recipient loop
						print("    email: " + la_recipient.item.email + " | status: " + la_recipient.item.status + " | Reject Reason: " + la_recipient.item.reject_reason + " | ID: " + la_recipient.item.id + "%N")
					end
				end
			end
		end


end
