class AddRestrictionNameToRestrictions < ActiveRecord::Migration[8.1]
  # The old enum's keys mapped to these display strings, which is what was
  # actually stored in restrictions.name.
  LABELS_BY_KEY = {
    "caffeine_free" => "Caffeine-Free",
    "dairy_free" => "Dairy Free",
    "gluten_free" => "Gluten Free",
    "kosher" => "Kosher",
    "nut_free" => "Nut Free",
    "organic" => "Organic"
  }.freeze

  class MigrationRestrictionName < ActiveRecord::Base
    self.table_name = "restriction_names"
  end

  class MigrationRestriction < ActiveRecord::Base
    self.table_name = "restrictions"
  end

  def up
    add_reference :restrictions, :restriction_name, foreign_key: true

    ids_by_label = LABELS_BY_KEY.values.index_with { |label| MigrationRestrictionName.find_or_create_by!(name: label).id }

    MigrationRestriction.reset_column_information
    MigrationRestriction.find_each do |restriction|
      restriction.update_column(:restriction_name_id, ids_by_label[restriction.name])
    end

    change_column_null :restrictions, :restriction_name_id, false
    remove_column :restrictions, :name, :string
  end

  def down
    add_column :restrictions, :name, :string

    MigrationRestriction.reset_column_information
    MigrationRestriction.find_each do |restriction|
      restriction_name = MigrationRestrictionName.find_by(id: restriction.restriction_name_id)
      restriction.update_column(:name, LABELS_BY_KEY.key(restriction_name.name)) if restriction_name
    end

    remove_reference :restrictions, :restriction_name, foreign_key: true
  end
end
