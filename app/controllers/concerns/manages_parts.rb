module ManagesParts
  extend ActiveSupport::Concern

  private

  def sync_restrictions(record, param_key)
    names = Array(params.dig(param_key, :restrictions)).reject(&:blank?)
    record.restrictions.where.not(name: names).destroy_all
    existing_names = record.restrictions.pluck(:name)
    (names - existing_names).each { |name| record.restrictions.create(name: name) }
  end
end
