module ManagesParts
  extend ActiveSupport::Concern

  private

  def sync_restrictions(record, param_key)
    names = Array(params.dig(param_key, :restrictions)).reject(&:blank?)
    record.restrictions.where.not(name: names).destroy_all
    existing_names = record.restrictions.pluck(:name)
    (names - existing_names).each { |name| record.restrictions.create(name: name) }
  end

  def next_sku_number(model_class, prefix)
    last = model_class.where(sku_prefix: prefix).maximum(:sku_number) || 0
    "%04d" % (last + 1)
  end
end
