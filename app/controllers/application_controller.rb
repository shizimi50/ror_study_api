class ApplicationController < ActionController::API
end


# 400 Bad Request
def response_bad_request
    render status: 400, json: { status: 400, message: "Bad Requestだよ" }
end
