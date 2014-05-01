
module Blog
  class API < API::Base
    resource :articles do
      helpers do
        def find_by_id(id)
          @article = Article.find_by(:id => id)
          unless @article.present?
            error!({ :error => 'article not found' }, 400)
          end
        end

        def valid_with_present
          if @article.valid?
            present @article
          else
            error_msgs = @article.errors.to_json
            logger.error error_msgs
            error!({ :error => error_msgs }, 400)
          end
        end
      end

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
        requires :author_name, type: String, desc: "article's author name"
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
        optional :author_name, type: String, desc: "article's author name"
        requires :article, type: Hash, desc: "article's new attributes"
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
