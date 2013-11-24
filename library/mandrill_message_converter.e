note
	description: "Summary description for {MANDRILL_MESSAGE_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MANDRILL_MESSAGE_CONVERTER

inherit
	MANDRILL_CONVERTER
	redefine
		to_json
	end

feature -- Conversion

    to_json (a_object: MANDRILL_MESSAGE): JSON_OBJECT
        do
            Result:=Precursor(a_object)
--            Result.put (json.value (a_object.uid), Uid_key)
--            Result.put (arguments_json_object (a_object), Arguments_key)
        end

feature    {NONE} -- Implementation

	arguments_json_object(a_object: MANDRILL_MESSAGE): JSON_OBJECT
		do
			create Result.make
            Result.put (message_json_object (a_object), Message_key)
--            put_argument_in_json(Result,a_object.template,Template_key)
--            put_argument_in_json(Result,a_object.recipient_override,Recipient_override_key)
--            if not a_object.recipients.is_empty then
--            	Result.put (recipient_json_object(a_object.recipients), Recipients_key)
--            end
--            if not a_object.headers.is_empty then
--            	Result.put (list_type_value_to_json(a_object.headers), Headers_key)
--            end
--			if not a_object.variables.is_empty then
--				Result.put (list_type_value_to_json(a_object.variables), Variables_key)
--			end
--			if not a_object.attachments.is_empty then
--				Result.put (attachments_json_object(a_object.attachments), Attachments_type_key)
--			end
		end

	put_argument_in_json(a_json:JSON_OBJECT;a_value:READABLE_STRING_GENERAL;a_key:JSON_STRING)
		do
			if not a_value.is_empty then
				a_json.put (json.value (a_value), a_key)
			end
		end

	put_boolean_in_json(a_json:JSON_OBJECT;a_value:BOOLEAN;a_key:JSON_STRING)
		do
			if a_value then
				a_json.put (json.value ("true"), a_key)
			else
				a_json.put (json.value ("false"), a_key)
			end
		end

	message_json_object(a_object: MANDRILL_MESSAGE): JSON_OBJECT
		do
			create Result.make
			put_argument_in_json(Result, a_object.html_message, Html_key)
			put_argument_in_json(Result, a_object.text_message,Text_key)
			put_argument_in_json(Result, a_object.subject,Subject_key)
			put_argument_in_json(Result, a_object.from_email,From_email_key)
			put_argument_in_json(Result, a_object.from_name,From_name_key)
			Result.put (to_json_object (a_object), To_key)
			Result.put (key_value_chain_json_object (a_object.headers), Headers_key)
			put_boolean_in_json(Result, a_object.is_important,Important_key)
			put_boolean_in_json(Result, a_object.must_track_opens,Track_opens_key)
			put_boolean_in_json(Result, a_object.must_generate_html,Auto_html_key)
			put_boolean_in_json(Result, a_object.must_inline_css,Inline_css_key)
			put_boolean_in_json(Result, a_object.must_strip_url,Url_strip_qs_key)
			put_boolean_in_json(Result, not a_object.must_expose_recipients,Preserve_recipients_key)
			put_boolean_in_json(Result, not a_object.must_remove_from_log,View_content_link_key)
			put_argument_in_json(Result, a_object.bcc_address,Bcc_address_key)
			put_argument_in_json(Result, a_object.tracking_domain,Tracking_domain_key)
			put_argument_in_json(Result, a_object.signing_domain,Signing_domain_key)
			put_argument_in_json(Result, a_object.return_path_domain,Return_path_domain_key)
			put_boolean_in_json(Result, a_object.must_merge_tags,Merge_key)
			Result.put (vars_json_object (a_object.global_merge_vars), Global_merge_vars_key)
			Result.put (merge_vars_json_object (a_object), Merge_vars_key)
			Result.put (string_chain_to_json_array (a_object.tags), Tags_key)
			put_argument_in_json(Result, a_object.sub_account,Subaccount_key)
			Result.put (string_chain_to_json_array (a_object.google_analytics_domains), Google_analytics_domains_key)
			Result.put (string_chain_to_json_array (a_object.google_analytics_campaigns), Google_analytics_campaign_key)
			Result.put (key_value_chain_json_object (a_object.metadata), Metadata_key)
			Result.put (recipient_metadata_json_object (a_object), Recipient_metadata_key)
			Result.put (attachments_json_object (a_object.attachments), Attachments_key)
			Result.put (attachments_json_object (a_object.embedded_images), Images_key)
			put_boolean_in_json(Result, a_object.is_async,Async_key)
			put_argument_in_json(Result, a_object.ip_pool,Ip_pool_key)
			if attached a_object.must_send_at as la_send_at then
				Result.put (put_date_in_json (la_send_at), send_at_key)
			end

		end

	to_json_object(a_object: MANDRILL_MESSAGE): JSON_ARRAY
		local
			l_to:JSON_OBJECT
		do
			create Result.make_array
			across
				a_object.recipients as la_recipient
			loop
				create l_to.make
				l_to.put (json.value (la_recipient.item.email), Email_key)
				l_to.put (json.value (la_recipient.item.name), Name_key)
				if la_recipient.item.is_bcc then
					l_to.put (json.value ("bcc"), Type_key)
				elseif la_recipient.item.is_cc then
					l_to.put (json.value ("cc"), Type_key)
				else
					l_to.put (json.value ("to"), Type_key)
				end
				Result.add (l_to)
			end
		end

	key_value_chain_json_object(a_chain:CHAIN[TUPLE[key,value:READABLE_STRING_GENERAL]]): JSON_OBJECT
		do
			create Result.make
			across
				a_chain as la_chain
			loop
				Result.put (json.value (la_chain.item.value),create {JSON_STRING}.make_json (la_chain.item.key.to_string_8))
			end
		end

	vars_json_object(a_vars:CHAIN[TUPLE[name, content:READABLE_STRING_GENERAL]]): JSON_ARRAY
		local
			l_var:JSON_OBJECT
		do
			create Result.make_array
			across
				a_vars as la_vars
			loop
				create l_var.make
				l_var.put (json.value (la_vars.item.name), Name_key)
				l_var.put (json.value (la_vars.item.content), Content_key)
				Result.add (l_var)
			end
		end

	merge_vars_json_object(a_object: MANDRILL_MESSAGE): JSON_ARRAY
		local
			l_merge_vars:JSON_OBJECT
		do
			create Result.make_array
			across
				a_object.merge_vars as la_merge_vars
			loop
				create l_merge_vars.make
				l_merge_vars.put (json.value (la_merge_vars.item.recipient), Rcpt_key)
				l_merge_vars.put (vars_json_object(la_merge_vars.item.vars), Vars_key)
				Result.add (l_merge_vars)
			end
		end

	string_chain_to_json_array(a_chain:CHAIN[READABLE_STRING_GENERAL]):JSON_ARRAY
		do
			create Result.make_array
			across
				a_chain as la_chain
			loop
				if attached json.value (la_chain.item) as la_json_string then
					Result.add(la_json_string)
				end
			end
		end

	recipient_metadata_json_object(a_object: MANDRILL_MESSAGE): JSON_ARRAY
		local
			l_recipient_metadata:JSON_OBJECT
		do
			create Result.make_array
			across
				a_object.recipient_metadata as la_recipient_metadata
			loop
				create l_recipient_metadata.make
				l_recipient_metadata.put (json.value (la_recipient_metadata.item.recipient), Rcpt_key)
				l_recipient_metadata.put (key_value_chain_json_object(la_recipient_metadata.item.vars), Values_key)
				Result.add (l_recipient_metadata)
			end
		end

	attachments_json_object(a_attachments: CHAIN[TUPLE[file_name, content_type, base64_encoded_content:READABLE_STRING_GENERAL]]): JSON_ARRAY
		local
			l_attachments:JSON_OBJECT
		do
			create Result.make_array
			across
				a_attachments as la_attachments
			loop
				create l_attachments.make
				l_attachments.put (json.value (la_attachments.item.content_type), Type_key)
				l_attachments.put (json.value (la_attachments.item.file_name), Name_key)
				l_attachments.put (json.value (la_attachments.item.base64_encoded_content), Content_key)
				Result.add (l_attachments)
			end
		end

	put_date_in_json(a_date:TUPLE[date:DATE;time:TIME]):JSON_STRING
		local
			l_date:STRING_8
		do
			l_date := a_date.date.formatted_out ("yyyy-[0]mm-[0]dd") + " " + a_date.time.formatted_out ("[0]hh:[0]mm:[0]ss")
			create Result.make_json (l_date)
		end



--	content_json_object(a_object: MANDRILL_MESSAGE): JSON_OBJECT
--		do
--			create Result.make
--			put_argument_in_json(Result, a_object.text_message, Text_message_key)
--			put_argument_in_json(Result, a_object.html_message, Html_message_key)
--		end

--	attachments_json_object(a_attachments:LIST[TUPLE[file_name, content_type, content:READABLE_STRING_GENERAL]]): JSON_OBJECT
--		local
--			l_attachment_object:JSON_OBJECT
--			l_key:JSON_STRING
--		do
--			create Result.make
--			across
--				a_attachments as ic_attachment
--			loop
--				create l_attachment_object.make
--				l_attachment_object.put (json.value (ic_attachment.item.content_type), Content_type_key)
--				l_attachment_object.put (json.value (ic_attachment.item.content), Content_key)
--				create l_key.make_json (ic_attachment.item.file_name.as_string_8)
--				Result.put (l_attachment_object, l_key)
--			end
--		end


--	recipient_json_object(a_recipients:LIST[TUPLE[recipient:READABLE_STRING_GENERAL;variables:detachable LIST[TUPLE[name,value:READABLE_STRING_GENERAL]]]]): JSON_OBJECT
--		local
--			l_key:JSON_STRING
--		do
--			create Result.make
--			across
--				a_recipients as ic_recipients
--			loop
--				create l_key.make_json (ic_recipients.item.recipient.as_string_8)
--				if attached ic_recipients.item.variables as la_variables then
--					Result.put (list_type_value_to_json(la_variables), l_key)
--				else
--					Result.put (json.value (Void), l_key)
--				end

--			end
--		end

--	list_json_object(a_list:LIST[READABLE_STRING_GENERAL]): JSON_VALUE
--    	local
--    		l_list_converter:JSON_LIST_CONVERTER
--		do
--			if attached {LINKED_LIST[READABLE_STRING_GENERAL]} a_list then
--            	create {JSON_LINKED_LIST_CONVERTER} l_list_converter.make
--            else
--            	create {JSON_ARRAYED_LIST_CONVERTER} l_list_converter.make
--            end
--            if attached l_list_converter.to_json (a_list) as al_json_value then
--            	Result:=al_json_value
--            else
--            	create {JSON_NULL} Result
--            	check False end
--            end

--		end

--	list_type_value_to_json(a_list:LIST[TUPLE[type,value:READABLE_STRING_GENERAL]]): JSON_OBJECT
--		local
--			l_key:JSON_STRING
--		do
--			create Result.make
--			across
--				a_list as ic_list
--			loop
--				create l_key.make_json (ic_list.item.type.as_string_8 )
--				Result.put (json.value (ic_list.item.value), l_key)
--			end
--		end
end
