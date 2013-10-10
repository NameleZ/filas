class CreateFilas < ActiveRecord::Migration
  def change
    create_table :filas do |t|
      t.string :nome
      t.integer :posicao_atual
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_foreign_key(:filas, :users)

  end
end
