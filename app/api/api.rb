
require 'v1/v1_api'
require 'v2/v2_api'

module API
  class Base < Grape::API
    mount API::V1
    mount API::V2
  end
end