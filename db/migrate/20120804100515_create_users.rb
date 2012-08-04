class CreateUsers < ActiveRecord::Migration

  def change

    create_table :users do |t|

      t.string  :name
      t.string  :password

      #enable :0 for disable user login and 1 for enable user login
      t.boolean :enable

      t.timestamps

    end

  end
end

