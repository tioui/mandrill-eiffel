note
	description: "Summary description for {MANDRILL_ANY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MANDRILL_ANY

inherit
	MANDRILL_CONSTANTS


feature -- Initialisation

	make(a_api_key:READABLE_STRING_GENERAL)
		do
			api_key:=a_api_key
			set_secure
			set_address(mandrill_address)
			json_result:=""
		end

feature -- Access

	api_key:READABLE_STRING_GENERAL

	is_secure:BOOLEAN

	set_secure
		do
			is_secure:=True
		end

	set_unsecure
		do
			is_secure:=False
		end

	address:READABLE_STRING_GENERAL assign set_address

	set_address(a_host:READABLE_STRING_GENERAL)
		do
			address:=a_host
		end

	json_request:READABLE_STRING_GENERAL
		local
			l_converter:MANDRILL_CONVERTER
			l_json_object:JSON_OBJECT
		do
			create l_converter
			l_json_object:=l_converter.to_json (Current)
			Result:=l_json_object.representation
		end

	json_result:READABLE_STRING_GENERAL

feature{NONE} -- Implementation

	send_request
		local
			l_address:READABLE_STRING_GENERAL
			l_curl_handle, l_content_type:POINTER
			l_result: INTEGER
			l_result_string:CURL_STRING
		do

			json_result:=""
			if is_secure then
				l_address:="https"
			else
				l_address:="http"
			end
			l_address:=l_address + "://" + address + request_path
			l_curl_handle := curl_easy.init
			if not l_curl_handle.is_default_pointer then
				curl_easy.set_write_function (l_curl_handle)
				create l_result_string.make_empty
				curl_easy.setopt_string (l_curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_address)
				curl_easy.setopt_string (l_curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, json_request)
				curl_easy.setopt_integer (l_curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_result_string.object_id)
				l_content_type:=curl.slist_append (l_content_type, "Content-type: application/json")
				curl_easy.setopt_slist (l_curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpheader, l_content_type)
				l_result := curl_easy.perform (l_curl_handle)
				json_result:=l_result_string
				curl_easy.cleanup (l_curl_handle)
			end
		end

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals
		once
			create Result
		end

	curl: CURL_EXTERNALS
			-- cURL easy externals
		once
			create Result
		end

	request_path:READABLE_STRING_GENERAL
		deferred
		end

	

end
