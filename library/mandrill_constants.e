note
	description: "Summary description for {MANDRILL_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MANDRILL_CONSTANTS

feature -- Generals

	Version:READABLE_STRING_GENERAL
		once
			Result:="1.0"
		end

feature {NONE} -- Implementation

	Mandrill_address:READABLE_STRING_GENERAL
		once
			Result:="mandrillapp.com/api/"+Version
		end

	Content_type:READABLE_STRING_GENERAL
		once
			Result:="Content-type: application/json"
		end

	User_agent:READABLE_STRING_GENERAL
		local
			l_ise:ISE_RUNTIME
		once
			create l_ise
			Result:="User-Agent: Mandrill-Eiffel "+Version
		end

feature {NONE} -- Any

    api_key_key: JSON_STRING
        once
            create Result.make_json ("key")
        end

feature {NONE} -- Send Message

	Send_message_path:READABLE_STRING_GENERAL
		once
			Result:="/messages/send.json"
		end

    Message_key: JSON_STRING
        once
            create Result.make_json ("message")
        end

    Html_key: JSON_STRING
        once
            create Result.make_json ("html")
        end

    Text_key: JSON_STRING
        once
            create Result.make_json ("text")
        end

    Subject_key: JSON_STRING
        once
            create Result.make_json ("subject")
        end

    From_email_key: JSON_STRING
        once
            create Result.make_json ("from_email")
        end

    From_name_key: JSON_STRING
        once
            create Result.make_json ("from_name")
        end

    To_key: JSON_STRING
        once
            create Result.make_json ("to")
        end

    Email_key: JSON_STRING
        once
            create Result.make_json ("email")
        end

    Headers_key: JSON_STRING
        once
            create Result.make_json ("headers")
        end

    Important_key: JSON_STRING
        once
            create Result.make_json ("important")
        end

    Track_opens_key: JSON_STRING
        once
            create Result.make_json ("track_opens")
        end

    Track_clicks_key: JSON_STRING
        once
            create Result.make_json ("track_clicks")
        end

    Auto_text_key: JSON_STRING
        once
            create Result.make_json ("auto_text")
        end

	Auto_html_key: JSON_STRING
        once
            create Result.make_json ("auto_html")
        end

    Inline_css_key: JSON_STRING
        once
            create Result.make_json ("inline_css")
        end

    Url_strip_qs_key: JSON_STRING
        once
            create Result.make_json ("url_strip_qs")
        end

    Preserve_recipients_key: JSON_STRING
        once
            create Result.make_json ("preserve_recipients")
        end

    View_content_link_key: JSON_STRING
        once
            create Result.make_json ("view_content_link")
        end

    Bcc_address_key: JSON_STRING
        once
            create Result.make_json ("bcc_address")
        end

    Tracking_domain_key: JSON_STRING
        once
            create Result.make_json ("tracking_domain")
        end

    Signing_domain_key: JSON_STRING
        once
            create Result.make_json ("signing_domain")
        end

    Return_path_domain_key: JSON_STRING
        once
            create Result.make_json ("return_path_domain")
        end

    Merge_key: JSON_STRING
        once
            create Result.make_json ("merge")
        end

    Global_merge_vars_key: JSON_STRING
        once
            create Result.make_json ("global_merge_vars")
        end

    Name_key: JSON_STRING
        once
            create Result.make_json ("name")
        end

    Content_key: JSON_STRING
        once
            create Result.make_json ("content")
        end





    Merge_vars_key: JSON_STRING
        once
            create Result.make_json ("merge_vars")
        end

    Rcpt_key: JSON_STRING
        once
            create Result.make_json ("rcpt")
        end

    Vars_key: JSON_STRING
        once
            create Result.make_json ("vars")
        end

    Tags_key: JSON_STRING
        once
            create Result.make_json ("tags")
        end

    Subaccount_key: JSON_STRING
        once
            create Result.make_json ("subaccount")
        end

    Google_analytics_domains_key: JSON_STRING
        once
            create Result.make_json ("google_analytics_domains")
        end

    Google_analytics_campaign_key: JSON_STRING
        once
            create Result.make_json ("google_analytics_campaign")
        end

    Metadata_key: JSON_STRING
        once
            create Result.make_json ("metadata")
        end

    Recipient_metadata_key: JSON_STRING
        once
            create Result.make_json ("recipient_metadata")
        end

    Values_key: JSON_STRING
        once
            create Result.make_json ("values")
        end

    Attachments_key: JSON_STRING
        once
            create Result.make_json ("attachments")
        end

    Type_key: JSON_STRING
        once
            create Result.make_json ("type")
        end

	Images_key: JSON_STRING
        once
            create Result.make_json ("Images")
        end

    Async_key: JSON_STRING
        once
            create Result.make_json ("async")
        end

    Ip_pool_key: JSON_STRING
        once
            create Result.make_json ("ip_pool")
        end

    Send_at_key: JSON_STRING
        once
            create Result.make_json ("send_at")
        end

feature {NONE} -- Send Message Result

	Status_key: JSON_STRING
        once
            create Result.make_json ("status")
        end

    Code_key: JSON_STRING
        once
            create Result.make_json ("code")
        end

    Id_key: JSON_STRING
        once
            create Result.make_json ("_id")
        end

    Reject_reason_key: JSON_STRING
        once
            create Result.make_json ("reject_reason")
        end

end
