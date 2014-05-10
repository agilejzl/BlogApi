class Article < ActiveRecord::Base
  belongs_to :author

  validates :title, :presence => true
  # validates :author_id, :presence => true
  
  def to_hash
    {
      :title => title,
      :content => content,
      :author_id => author.try(:id)
    }
  end

  def author_name
    author.try(:name)
  end

  def author_name=(name)
    unless name.blank?
      author = Author.find_or_create_by(:name => name)
      self.author = author
      author.name
    end
  end
end