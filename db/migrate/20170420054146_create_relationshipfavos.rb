class CreateRelationshipfavos < ActiveRecord::Migration[5.0]
  def change
    create_table :relationshipfavos do |t|
      t.references :user, foreign_key: true
      t.references :favorite, foreign_key: { to_table: :microposts }

      t.timestamps
      
      t.index [:user_id, :favorite_id], unique: true
    end
  end
end
