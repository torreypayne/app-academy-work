class Album < ActiveRecord::Base
  validates :band_id, :studio, :album_name, presence: true

  belongs_to :band
  has_many :tracks, dependent: :destroy

end
