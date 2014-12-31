class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :caption
      t.string :matter

      t.timestamps
    end
  end

  change_column :articles, :matter, :text
end
