module Spina
  class StructurePart < ApplicationRecord
    include LegacyPart
    include ImageCollectable
    include Optionable

    belongs_to :structure_item, optional: true
    belongs_to :structure_partable, polymorphic: true, optional: true

    accepts_nested_attributes_for :structure_partable, allow_destroy: true

    validates :structure_partable_type, presence: true
    validates :name, uniqueness: {scope: :structure_item_id}

    alias_attribute :partable, :structure_partable
    alias_attribute :partable_id, :structure_partable_id
    alias_attribute :partable_type, :structure_partable_type
    alias_method :structure_partable_attributes=, :partable_attributes=

    def convert_to_json!
      new_part = structure_partable.convert_to_json!
      new_part.name = name
      new_part
    end
  end
end
