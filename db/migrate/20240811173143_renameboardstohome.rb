class RenameboardsTohome < ActiveRecord::Migration[7.1]
  def change
    rename_table :boards, :home
  end
end
