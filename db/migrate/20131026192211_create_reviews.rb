class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.references :user, index: true
      t.references :book, index: true

      t.timestamps
    end
  end
end
