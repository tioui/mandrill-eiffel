note
	description: "Summary description for {MANDRILL_MESSAGE_RESULT_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MANDRILL_MESSAGE_RESULT_CONVERTER

inherit
	SHARED_EJSON
	MANDRILL_CONSTANTS

create {MANDRILL_MESSAGE}
	default_create

feature {MANDRILL_MESSAGE} -- Access

	from_json(a_result_code:NATURAL_16;a_json:READABLE_STRING_GENERAL):MANDRILL_MESSAGE_RESULT
		local
			l_parser:JSON_PARSER
			l_recipients_json:JSON_ARRAY
			l_error_json:JSON_OBJECT
			l_status, l_name, l_message:READABLE_STRING_GENERAL
			l_code:NATURAL_16
		do
			create l_parser.make_parser (a_json.to_string_8)
			if a_result_code=200 then
				create Result.make (a_result_code)
				l_recipients_json:=l_parser.parse_array
				fill_recipients(Result.recipients,l_recipients_json)
			else
				l_error_json:=l_parser.parse_object
				l_status:=get_string_from_json_item(json.object (l_error_json.item (Status_key), Void))
				l_code:=get_number_from_json_item(json.object (l_error_json.item (Code_key), Void))
				l_name:=get_string_from_json_item(json.object (l_error_json.item (Name_key), Void))
				l_message:=get_string_from_json_item(json.object (l_error_json.item (Message_key), Void))
				create Result.make_error (a_result_code, l_code, l_status, l_name, l_message)
			end
		end

	fill_recipients(a_recipients:LIST[TUPLE[email,status,id,reject_reason:READABLE_STRING_GENERAL]];a_json:JSON_ARRAY)
		local
			l_cursor:ITERATION_CURSOR[JSON_VALUE]
		do
			from
				l_cursor:=a_json.new_cursor
			until
				l_cursor.after
			loop
				if attached {JSON_OBJECT} l_cursor.item as la_object then
					if attached json.object (la_object.item (Email_key),Void) as la_email then
						if attached json.object (la_object.item (Status_key),Void) as la_status then
							if attached json.object (la_object.item (Id_key),Void) as la_id then
								if attached la_object.item (Reject_reason_key) as la_reject_reason then
									if attached {JSON_NULL} la_reject_reason as la_null then
										a_recipients.extend ([get_string_from_json_item(la_email), get_string_from_json_item(la_status), get_string_from_json_item(la_id), ""])
									else
										a_recipients.extend ([get_string_from_json_item(la_email), get_string_from_json_item(la_status), get_string_from_json_item(la_id), get_string_from_json_item(json.object (la_reject_reason,Void))])
									end

								end
							end
						end
					end
				end
				l_cursor.forth
			end
		end

	get_string_from_json_item(a_json_item:detachable ANY):READABLE_STRING_GENERAL
		do
			if attached {READABLE_STRING_GENERAL} a_json_item as la_item then
				Result:=la_item
			else
				Result:=""
			end
		end

	get_number_from_json_item(a_json_item:detachable ANY):NATURAL_16
		do
			if attached {NATURAL_16} a_json_item as la_item then
				Result:=la_item
			else
				Result:=0
			end
		end

end
