class AddLinkToFilas < ActiveRecord::Migration
  def change
    add_column :filas, :link, :string
  end
end
