class CreateUserDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_documents do |t|
      t.integer :user_id
      t.integer :document_type_id

      t.timestamps
    end
    add_index :user_documents, :user_id
  	add_index :user_documents, :document_type_id
  end
end
