class CreatePostCategoryships < ActiveRecord::Migration[6.1]
  def change
    create_table :post_categoryships do |t|
      t.belongs_to :post
      t.belongs_to :category
      t.timestamps
    end
  end
end
