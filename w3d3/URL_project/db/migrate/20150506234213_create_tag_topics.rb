class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic, unique: true

      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :topic_id
      t.integer :url_id

      t.timestamps
    end
  end
end
