require "#{Rails.root}/app/api/v1/helpers"

module API
  class V1 < Grape::API
    helpers BlogApi::HelpersV1

    format :json
    version 'v1', :using => :path
    default_error_status 400
    default_error_formatter :json

    resource :articles do

      desc "get all articles information"
      get do
        paginate_params = { :page => params[:page], :per_page => params[:per_page] || 20 }
        @articles = Article.includes(:author).paginate(paginate_params)
        present @articles
      end

      desc "return an artice"
      params do
        requires :id, :type => Integer, :desc => "artice id"
      end
      route_param :id do
        get do
          find_by_id params[:id]
          present @article
        end
      end

      desc "create an article"
      params do
        requires :author_name, type: String, desc: "author1's name"
        requires :article, type: Hash, desc: "article's attributes"
      end
      post do
        authenticate!
        @author =  Author.find_or_create_by(:name => params[:author_name])
        @article = Article.create(params[:article].merge(:author_id => @author.id))
        valid_with_present
      end

      desc "update an exist article"
      params do
        optional :author_name, type: String, desc: "a newer name"
        requires :article, type: Hash, desc: "updated attributes"
      end
      put ':id' do
        authenticate!
        find_by_id params[:id]

        if params[:author_name]
          @author =  Author.find_or_create_by(:name => params[:author_name])
          @article.update_attributes(params[:article].merge(:author_id => @author.id))
        else
          @article.update_attributes(params[:article])
        end

        valid_with_present
      end

      desc "delete an article"
      params do
        requires :id, type: Integer, desc: "article id"
      end
      delete ':id' do
        authenticate!
        find_by_id params[:id]
        @article.destroy

        if @article.persisted?
          error!({ :error => 'delete article failed' }, 400)
        else
          true
        end
      end

    end
  end
end
