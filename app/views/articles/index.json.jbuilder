json.array!(@articles) do |article|
  json.extract! article, :id, :title, :content, :author_id
  json.url article_url(article, format: :json)
end
