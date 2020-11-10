class Records < ActiveRecord::Migration[5.2]
  def up
  	 drop_table :spots
  end

  def down
  end

end
