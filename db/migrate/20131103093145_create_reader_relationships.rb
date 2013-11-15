class CreateReaderRelationships < ActiveRecord::Migration
  def change
    create_table :reader_relationships do |t|
      t.integer :reader_id
      t.integer :read_id

      t.timestamps
    end
    add_index :reader_relationships, :reader_id
    add_index :reader_relationships, :read_id
    add_index :reader_relationships, [:reader_id, :read_id], unique: true
  end
end
