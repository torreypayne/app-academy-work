class Track < ActiveRecord::Base
  validates :band_id, :kind, :track_name, presence: true

  belongs_to :album
  belongs_to(:band, through: :album, source: :band)
end
