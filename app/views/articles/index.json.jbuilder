json.array!(@articles) do |article|
  json.extract! article, :id, :title, :caption, :matter
  json.url article_url(article, format: :json)
end
