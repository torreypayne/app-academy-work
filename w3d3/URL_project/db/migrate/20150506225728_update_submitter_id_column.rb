class UpdateSubmitterIdColumn < ActiveRecord::Migration
  def change
    change_column :shortened_urls, :submitter_id, :integer
  end
end
