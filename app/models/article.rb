class Article < ActiveRecord::Base
  belongs_to :author

  validates :title, :presence => true
  # validates :author_id, :presence => true
  
  def to_hash
    {
      :title => title,
      :content => content,
      :author_id => author.id
    }
  end
end