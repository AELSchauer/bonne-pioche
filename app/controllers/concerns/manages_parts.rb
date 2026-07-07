module ManagesParts
  extend ActiveSupport::Concern

  private

  def sync_restrictions(record, param_key)
    restriction_name_ids = Array(params.dig(param_key, :restrictions)).reject(&:blank?).map(&:to_i)
    record.restrictions.where.not(restriction_name_id: restriction_name_ids).destroy_all
    existing_ids = record.restrictions.pluck(:restriction_name_id)
    (restriction_name_ids - existing_ids).each { |id| record.restrictions.create(restriction_name_id: id) }
  end
end
