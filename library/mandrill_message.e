note
	description: "Summary description for {MANDRILL_MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MANDRILL_MESSAGE

inherit
	MANDRILL_ANY
	rename
		make as make_any
	redefine
		json_request
	end

create
	make

feature {NONE} -- Initialization

	make(a_api_key:READABLE_STRING_GENERAL)
			-- Initialization for `Current'.
		do
			make_any(a_api_key)
			create {ARRAYED_LIST[TUPLE[name,email:READABLE_STRING_GENERAL;is_cc,is_bcc:BOOLEAN]]} recipients.make(1)
			create {ARRAYED_LIST[TUPLE[type,value:READABLE_STRING_GENERAL]]} headers.make(0)
			set_html_message ("")
			set_text_message ("")
			set_from_email ("")
			set_from_name ("")
			set_subject ("")
			set_important(False)
			set_track_opens(False)
			set_track_clicks(False)
			set_generate_text(False)
			set_strip_url(False)
			set_inline_css(False)
			set_expose_recipients(False)
			set_remove_from_log(False)
			set_bcc_address("")
			set_tracking_domain("")
			set_signing_domain("")
			set_return_path_domain("")
			set_ip_pool("")
			set_merge_tags(False)
			create {ARRAYED_LIST[TUPLE[name, content:READABLE_STRING_GENERAL]]} global_merge_vars.make (0)
			create {ARRAYED_LIST[TUPLE[recipient:READABLE_STRING_GENERAL; vars:LIST[TUPLE[name, content:READABLE_STRING_GENERAL]]]]} merge_vars.make (0)
			create {ARRAYED_LIST[READABLE_STRING_GENERAL]} tags.make (0)
			create {ARRAYED_LIST[READABLE_STRING_GENERAL]} google_analytics_domains.make (0)
			create {ARRAYED_LIST[READABLE_STRING_GENERAL]} google_analytics_campaigns.make (0)
			set_sub_account("")
			create {ARRAYED_LIST[TUPLE[name,value:READABLE_STRING_GENERAL]]} metadata.make(0)
			create {ARRAYED_LIST[TUPLE[recipient:READABLE_STRING_GENERAL; vars:LIST[TUPLE[name, value:READABLE_STRING_GENERAL]]]]} recipient_metadata.make (0)
			create {ARRAYED_LIST[TUPLE[file_name, content_type, base64_encoded_content:READABLE_STRING_GENERAL]]} attachments.make (0)
			create {ARRAYED_LIST[TUPLE[file_name, content_type, base64_encoded_content:READABLE_STRING_GENERAL]]} embedded_images.make (0)
			set_async(False)
			set_send_at(Void)
		end

feature -- Access

	text_message:READABLE_STRING_GENERAL assign set_text_message

	set_text_message(a_text_message:READABLE_STRING_GENERAL)
		do
			text_message:=a_text_message
		end

	html_message:READABLE_STRING_GENERAL assign set_html_message

	set_html_message(a_html_message:READABLE_STRING_GENERAL)
		do
			html_message:=a_html_message
		end

	subject:READABLE_STRING_GENERAL assign set_subject

	set_subject(a_subject:READABLE_STRING_GENERAL)
		do
			subject:=a_subject
		end

	from_email:READABLE_STRING_GENERAL assign set_from_email

	set_from_email(a_from_email:READABLE_STRING_GENERAL)
		do
			from_email:=a_from_email
		end

	from_name:READABLE_STRING_GENERAL assign set_from_name

	set_from_name(a_from_name:READABLE_STRING_GENERAL)
		do
			from_name:=a_from_name
		end

	recipients:LIST[TUPLE[name,email:READABLE_STRING_GENERAL;is_cc,is_bcc:BOOLEAN]]

	add_recipient(a_name,a_email:READABLE_STRING_GENERAL;a_is_cc,a_is_bcc:BOOLEAN)
		do
			recipients.extend ([a_name,a_email,a_is_cc,a_is_bcc])
		end

	headers:LIST[TUPLE[type,value:READABLE_STRING_GENERAL]]

	add_header(a_type,a_value:READABLE_STRING_GENERAL)
		do
			headers.extend ([a_type,a_value])
		end

	is_important:BOOLEAN assign set_important

	set_important(a_is_important:BOOLEAN)
		do
			is_important:=a_is_important
		end

	must_track_opens:BOOLEAN assign set_track_opens

	set_track_opens(a_must_track_opens:BOOLEAN)
		do
			must_track_opens:=a_must_track_opens
		end

	must_track_clicks:BOOLEAN assign set_track_clicks

	set_track_clicks(a_must_track_clicks:BOOLEAN)
		do
			must_track_clicks:=a_must_track_clicks
		end

	must_generate_text:BOOLEAN assign set_generate_text

	set_generate_text(a_must_generate_text:BOOLEAN)
		do
			must_generate_text:=a_must_generate_text
		end

	must_generate_html:BOOLEAN assign set_generate_html

	set_generate_html(a_must_generate_html:BOOLEAN)
		do
			must_generate_html:=a_must_generate_html
		end

	must_inline_css:BOOLEAN assign set_inline_css

	set_inline_css(a_must_inline_css:BOOLEAN)
		do
			must_inline_css:=a_must_inline_css
		end

	must_strip_url:BOOLEAN assign set_strip_url

	set_strip_url(a_must_strip_url:BOOLEAN)
		do
			must_strip_url:=a_must_strip_url
		end

	must_expose_recipients:BOOLEAN

	set_expose_recipients(a_must_expose_recipients:BOOLEAN)
		do
			must_expose_recipients:=a_must_expose_recipients
		end

	must_remove_from_log:BOOLEAN assign set_remove_from_log

	set_remove_from_log(a_must_remove_from_log:BOOLEAN)
		do
			must_remove_from_log:=a_must_remove_from_log
		end

	bcc_address:READABLE_STRING_GENERAL assign set_bcc_address

	set_bcc_address(a_bcc_address:READABLE_STRING_GENERAL)
		do
			bcc_address:=a_bcc_address
		end

	tracking_domain:READABLE_STRING_GENERAL assign set_tracking_domain

	set_tracking_domain(a_tracking_domain:READABLE_STRING_GENERAL)
		do
			tracking_domain:=a_tracking_domain
		end

	signing_domain:READABLE_STRING_GENERAL assign set_signing_domain

	set_signing_domain(a_signing_domain:READABLE_STRING_GENERAL)
		do
			signing_domain:=a_signing_domain
		end

	return_path_domain:READABLE_STRING_GENERAL assign set_return_path_domain

	set_return_path_domain(a_return_path_domain:READABLE_STRING_GENERAL)
		do
			return_path_domain:=a_return_path_domain
		end

	must_merge_tags:BOOLEAN assign set_merge_tags

	set_merge_tags(a_must_merge_tags:BOOLEAN)
		do
			must_merge_tags:=a_must_merge_tags
		end

	global_merge_vars:LIST[TUPLE[name, content:READABLE_STRING_GENERAL]]

	add_global_merge_var(a_name, a_content:READABLE_STRING_GENERAL)
		do
			global_merge_vars.extend ([a_name, a_content])
		end

	merge_vars:LIST[TUPLE[recipient:READABLE_STRING_GENERAL; vars:LIST[TUPLE[name, content:READABLE_STRING_GENERAL]]]]

	add_merge_vars(a_recipient:READABLE_STRING_GENERAL; a_vars:LIST[TUPLE[name, content:READABLE_STRING_GENERAL]])
		do
			merge_vars.extend ([a_recipient,a_vars])
		end

	tags:LIST[READABLE_STRING_GENERAL]

	add_tags(a_tag:READABLE_STRING_GENERAL)
		require
			Tag_Not_Starting_With_Underscore: not a_tag.starts_with ("_")
		do
			tags.extend (a_tag)
		end

	sub_account:READABLE_STRING_GENERAL assign set_sub_account

	set_sub_account(a_sub_account:READABLE_STRING_GENERAL)
		do
			sub_account:=a_sub_account
		end

	google_analytics_domains:LIST[READABLE_STRING_GENERAL]

	add_google_analytics_domain(a_google_analytics_domain:READABLE_STRING_GENERAL)
		do
			google_analytics_domains.extend(a_google_analytics_domain)
		end

	google_analytics_campaigns:LIST[READABLE_STRING_GENERAL]

	add_google_analytics_campaign(a_google_analytics_campaign:READABLE_STRING_GENERAL)
		do
			google_analytics_campaigns.extend(a_google_analytics_campaign)
		end

	metadata:LIST[TUPLE[name,value:READABLE_STRING_GENERAL]]

	add_metadata(a_name,a_value:READABLE_STRING_GENERAL)
		do
			metadata.extend ([a_name,a_value])
		end

	recipient_metadata:LIST[TUPLE[recipient:READABLE_STRING_GENERAL; vars:LIST[TUPLE[name, value:READABLE_STRING_GENERAL]]]]

	add_recipient_metadata(a_recipient:READABLE_STRING_GENERAL; a_vars:LIST[TUPLE[name, value:READABLE_STRING_GENERAL]])
		do
			recipient_metadata.extend ([a_recipient,a_vars])
		end

	attachments:LIST[TUPLE[file_name, content_type, base64_encoded_content:READABLE_STRING_GENERAL]]

	attach_file(a_file_name:READABLE_STRING_GENERAL)
		require
			Attach_File_Is_Valid: 	(attached {FILE} (create {RAW_FILE}.make_with_name (a_file_name)) as la_file) implies
									la_file.exists and then la_file.is_readable
		do
			attach_file_with_content_type(a_file_name,find_content_type(a_file_name))
		end

	attach_file_with_content_type(a_file_name,a_content_type:READABLE_STRING_GENERAL)
		require
			Attach_File_Is_Valid: 	(attached {FILE} (create {RAW_FILE}.make_with_name (a_file_name)) as la_file) implies
									la_file.exists and then la_file.is_readable
		local
			l_file:FILE
			l_data:ARRAYED_LIST[NATURAL_8]
		do
			create {RAW_FILE} l_file.make_open_read (a_file_name)
			create l_data.make (l_file.count)
			from
				l_file.start
			until
				l_file.end_of_file
			loop
				l_file.read_natural_8
				if not l_file.end_of_file then
					l_data.extend (l_file.last_natural_8)
				end
			end
			attach_from_memory_with_content_type(a_file_name, a_content_type, l_data.area.to_array)
		end

	attach_from_memory(a_file_name:READABLE_STRING_GENERAL;a_data:ARRAY[NATURAL_8])
		do
			attach_from_memory_with_content_type(a_file_name, find_content_type(a_file_name),a_data)
		end

	attach_from_memory_with_content_type(a_file_name,a_content_type:READABLE_STRING_GENERAL;a_data:ARRAY[NATURAL_8])
		local
			l_encoder:BASE64_ARRAY_ENCODER
		do
			create l_encoder
			attachments.extend ([get_file_name(a_file_name), a_content_type, l_encoder.encode64 (a_data)])
		end

	attach_from_string(a_file_name,a_data:READABLE_STRING_GENERAL)
		do
			attach_from_string_with_content_type(a_file_name,find_content_type(a_file_name),a_data)
		end

	attach_from_string_with_content_type(a_file_name,a_content_type,a_data:READABLE_STRING_GENERAL)
		local
			l_encoder:BASE64_STRING_ENCODER
		do
			create l_encoder
			attachments.extend ([get_file_name(a_file_name), a_content_type, l_encoder.encode64 (a_data.to_string_8)])
		end



	embedded_images:LIST[TUPLE[file_name, content_type, base64_encoded_content:READABLE_STRING_GENERAL]]

	attach_embedded_images_file(a_file_name:READABLE_STRING_GENERAL)
		require
			Attach_File_Is_Valid: 	(attached {FILE} (create {RAW_FILE}.make_with_name (a_file_name)) as la_file) implies
									la_file.exists and then la_file.is_readable
		do
			attach_embedded_images_file_with_content_type(a_file_name,find_content_type(a_file_name))
		end

	attach_embedded_images_file_with_content_type(a_file_name,a_content_type:READABLE_STRING_GENERAL)
		require
			Attach_File_Is_Valid: 	(attached {FILE} (create {RAW_FILE}.make_with_name (a_file_name)) as la_file) implies
									la_file.exists and then la_file.is_readable
			File_Is_Image:	a_content_type.starts_with ("image/")
		local
			l_file:FILE
			l_data:ARRAYED_LIST[NATURAL_8]
		do
			create {RAW_FILE} l_file.make_open_read (a_file_name)
			create l_data.make (l_file.count)
			from
				l_file.start
			until
				l_file.end_of_file
			loop
				l_file.read_natural_8
				if not l_file.end_of_file then
					l_data.extend (l_file.last_natural_8)
				end
			end
			attach_embedded_images_from_memory_with_content_type(a_file_name, a_content_type, l_data.area.to_array)
		end

	attach_embedded_images_from_memory(a_file_name:READABLE_STRING_GENERAL;a_data:ARRAY[NATURAL_8])
		do
			attach_embedded_images_from_memory_with_content_type(a_file_name, find_content_type(a_file_name),a_data)
		end

	attach_embedded_images_from_memory_with_content_type(a_file_name,a_content_type:READABLE_STRING_GENERAL;a_data:ARRAY[NATURAL_8])
		Require
			File_Is_Image:	a_content_type.starts_with ("image/")
		local
			l_encoder:BASE64_ARRAY_ENCODER
		do
			create l_encoder
			embedded_images.extend ([get_file_name(a_file_name), a_content_type, l_encoder.encode64 (a_data)])
		end

	is_async:BOOLEAN assign set_async

	set_async(a_is_async:BOOLEAN)
		do
			is_async:=a_is_async
		end

	ip_pool:READABLE_STRING_GENERAL assign set_ip_pool

	set_ip_pool(a_ip_pool:READABLE_STRING_GENERAL)
		do
			ip_pool:=a_ip_pool
		end

	must_send_at:detachable TUPLE[send_date:DATE;send_time:TIME] assign set_send_at

	set_send_at(a_date:detachable TUPLE[send_ate:DATE;send_time:TIME])
		do
			must_send_at:=a_date
		end

	send
		do
			print(json_request+"%N")
			send_request
			print(json_result+"%N")
		end

	json_request:READABLE_STRING_GENERAL
		local
			l_converter:MANDRILL_MESSAGE_CONVERTER
			l_json_object:JSON_OBJECT
		do
			create l_converter
			l_json_object:=l_converter.to_json (Current)
			Result:=l_json_object.representation

		end


feature {NONE} -- Implementation

	request_path:READABLE_STRING_GENERAL
		once
			Result:=Send_message_path
		end

	find_content_type(a_file_name:READABLE_STRING_GENERAL):READABLE_STRING_GENERAL
		local
			l_mime_detector:HTTP_FILE_EXTENSION_MIME_MAPPING
			l_extension:detachable READABLE_STRING_GENERAL
			l_extension_position, l_temp_position:INTEGER
			l_fin:BOOLEAN
		do
			from
				l_extension_position:=1
				l_fin:=False
			until
				l_fin
			loop
				l_temp_position:= a_file_name.index_of ('.', l_extension_position)
				if l_temp_position=0 then
					l_fin:=True
				else
					l_extension_position:=l_temp_position+1
				end
			end
			create l_mime_detector.make_default
			l_extension:=l_mime_detector.mime_type (a_file_name.substring (l_extension_position, a_file_name.count))
			if attached l_extension as la_extension then
				Result:=la_extension
			else
				Result:="application/octet-stream"
			end
		end

	get_file_name(a_file_name:READABLE_STRING_GENERAL):READABLE_STRING_GENERAL
		local
			l_file:FILE
		do
			create {RAW_FILE} l_file.make_with_name (a_file_name)
			Result := l_file.path.components.last.name
		end



end
