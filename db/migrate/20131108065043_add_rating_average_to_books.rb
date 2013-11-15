class AddRatingAverageToBooks < ActiveRecord::Migration
  def change
    add_column :books, :rating_average, :decimal, :default => 0, :precision => 6, :scale => 2
  end
end
