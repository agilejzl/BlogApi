class Author < ActiveRecord::Base
  has_many :articles, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
end