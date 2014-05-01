
module Blog
  class API < API::Base
    resource :articles do

      desc "get all articles information"
      get do
        @articles = Article.includes(:author).paginate(:page => params[:page], :per_page => params[:per_page] || 20)
        present @articles
      end

      desc "return an artice"
      params do
        requires :id, :type => Integer, :desc => "artice id"
      end
      route_param :id do
        get do
          @article = Article.find_by(:id => params[:id])
          
          if @article.present?
            present @article
          else
            error!({ :error => 'recorrd not found' }, 400)
          end
        end
      end

      desc "create an article"
      params do
        requires :article, type: Hash, desc: "article's attributes"
      end
      post do
        authenticate!
        @article = Article.new(params[:article])

        if @article.save
          present @article
        else
          error_msgs = @article.errors.to_json
          logger.error error_msgs
          error!({ :error => error_msgs }, 400)
        end
      end

      desc "update an exist article"
      params do
        requires :article, type: Hash, desc: "article's new attributes"
      end
      put ':id' do
        authenticate!
        @article = Article.find(params[:id])

        if @article.update_attributes(params[:article])
          present @article
        else
          error!({ :error => 'update article failed' }, 400)
        end
      end

      desc "delete an article"
      params do
        requires :id, type: Integer, desc: "article id"
      end
      delete ':id' do
        authenticate!
        @article = Article.find_by(:id => params[:id])

        if @article.present?
          @article.destroy
          if @article.persisted?
            error!({ :error => 'delete article failed' }, 400)
          end
        else
          error!({ :error => 'article not found' }, 400)
        end
      end

    end
  end
end
