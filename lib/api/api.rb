
module V1
  class API < API::Base
    module Helpers
      def server_time
        Time.now.strftime('%Y-%m-%d %H:%M:%S')
      end
    end

    helpers Helpers

    resource :articles do

      desc "get all articles information"
      get do
        puts "get articles at #{server_time}"
        Article.limit(10)
      end

      desc "return an artice"
      params do
        requires :id, :type => Integer, :desc => "artice id"
      end
      route_param :id do
        get do
          Article.find(params[:id])
        end
      end

      desc "create an article"
      params do
        requires :title, type: String, desc: "title of article"
        requires :content, type: String, desc: "content of article"
        requires :author_id, type: Integer, desc: "author_id of article"
      end
      post do
        authenticate!
        Article.create!({
          title: params[:title],
          content: params[:content],
          author_id: params[:author_id]
        })
      end

      desc "update an article"
      params do
        requires :title, type: String, desc: "title of article"
        requires :content, type: String, desc: "content of article"
        requires :author_id, type: Integer, desc: "author_id of article"
      end
      put ':id' do
        authenticate!
        Article.find(params[:id]).update({
          title: params[:title],
          content: params[:content],
          author_id: params[:author_id]
        })
      end

      desc "delete an article"
      params do
        requires :id, type: Integer, desc: "article id"
      end
      delete ':id' do
        authenticate!
        Article.find(params[:id]).destroy
      end

    end
  end
end
