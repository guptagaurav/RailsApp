class Article < ActiveRecord::Base

  has_many :comments

  attr_accessor :search
  # cattr_accessor :current
  # def to_param
  #   "#{id} #{title}".parameterize
  # end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]

  def slug_candidates
    [
        :title,
        [:title, :id]
    ]
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
