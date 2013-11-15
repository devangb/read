class AddAmazonLinkToBooks < ActiveRecord::Migration
  def change
    add_column :books, :amazon_link, :string
  end
end
