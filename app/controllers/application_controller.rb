class ApplicationController < ActionController::API
end

# 400 Bad Request
def response_bad_request_title
    render status: 400, json: { status: 400, message: "必須項目のタイトルがありません" }
end

# 400 Bad Request
def response_bad_request_content
    render status: 400, json: { status: 400, message: "必須項目の内容がありません" }
end

# 400 Bad Request
def response_bad_request_title_valid
    render status: 400, json: { status: 400, message: "文字数は140文字以内です" }
end

# 400 Bad Request
def response_bad_request_content_valid
    render status: 400, json: { status: 400, message: "文字数は1000文字以内です" }
end
# 400 Bad Request
def response_bad_request_comment_valid
    render status: 400, json: { status: 400, message: "文字数は255文字以内です" }
end




