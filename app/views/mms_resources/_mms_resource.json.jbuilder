json.extract! mms_resource, :id, :filename, :created_at, :updated_at
json.url mms_resource_url(mms_resource, format: :json)
