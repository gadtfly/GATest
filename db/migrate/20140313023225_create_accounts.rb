class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :refresh_token

      t.timestamps
    end
  end
end
