
require 'v1/v1_api'

module API
  class Base < Grape::API
    mount API::V1
  end
end