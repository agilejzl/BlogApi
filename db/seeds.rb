
if Article.count == 0
  author1 = Author.find_or_create_by(:name => 'author')
  author2 = Author.find_or_create_by(:name => 'author2') 
  Article.create([
    { :title => 'title', :content => 'content', :author_id => author1.id },
    { :title => 'title2', :content => 'content2', :author_id => author2.id }
  ])
end