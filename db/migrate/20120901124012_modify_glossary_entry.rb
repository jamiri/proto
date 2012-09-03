class ModifyGlossaryEntry < ActiveRecord::Migration

  def up
    add_column :glossary_entries, :pronun_file, :string
    add_column :glossary_entries, :image_file, :string
    add_column :glossary_entries, :ext_link, :string
  end

  def down
    remove_column :glossary_entries, :pronun_file, :string
    remove_column :glossary_entries, :image_file, :string
    remove_column :glossary_entries, :ext_link, :string
  end

end
