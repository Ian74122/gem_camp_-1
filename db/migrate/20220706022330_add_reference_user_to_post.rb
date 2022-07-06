class AddReferenceUserToPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :user
  end
end
