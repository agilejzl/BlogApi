
module BlogApi
  module HelpersV2
    def logger
      Grape::API.logger
    end

    def authenticate!
      # error!({status: 401, status_code: 'unauthorized'}, 401) unless current_user
    end

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
end