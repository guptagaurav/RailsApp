class Article < ActiveRecord::Base

  attr_accessor :search

  cattr_accessor :current


  searchable do
    string :title,:caption
    text :matter
    string :email
  end

  has_attached_file :photo

  validates :title, :presence => true,
            :length => { :maximum => 50}
  validates :caption, :presence => true
  validates :matter, :presence => true

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']



end
