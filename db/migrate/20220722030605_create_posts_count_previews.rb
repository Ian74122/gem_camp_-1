class CreatePostsCountPreviews < ActiveRecord::Migration[6.1]
  def change
    create_view :posts_count_previews
  end
end
