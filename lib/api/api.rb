
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
        puts "\nGet articles at #{server_time}"
        Article.limit(10)
      end

      desc "return an artice"
      params do
        requires :id, :type => Integer, :desc => "artice id"
      end
      route_param :id do
        get do
          article = Article.find(params[:id])
        end
      end

      desc "create an article"
      params do
        requires :article, type: Hash, desc: "article's attributes"
      end
      post do
        authenticate!
        article = Article.create!(params[:article])
      end

      desc "update an exist article"
      params do
        requires :article, type: Hash, desc: "article's new attributes"
      end
      put ':id' do
        authenticate!
        article = Article.find(params[:id])
        article.update(params[:article])
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
