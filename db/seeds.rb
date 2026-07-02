# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

exclusion_name = "Caffeine-Free"

subcategory = Subcategory.create(name: "Tea", category: Category.create(name: "Beverage"))
assembly1 = GiftAssembly.create(sku_prefix: "GFT", subcategory:, name: "Tea Sampler", status: :draft, tier: :common)
line_item1_1 = AssemblyLineItem.create(assembly: assembly1, quantity: 4)
line_item1_2 = AssemblyLineItem.create(assembly: assembly1, quantity: 1)
line_item1_3 = AssemblyLineItem.create(assembly: assembly1, quantity: 1)

tea_sachets = [
  [ "Apricot Escape Sachet", exclusion_name ],
  [ "Bright Eyed Sachet", exclusion_name ],
  [ "Dark Chocolate Peppermint Sachet", "" ],
  [ "Earl Grey Crème Sachet", "" ],
  [ "Egyptian Chamomile Sachet", exclusion_name ],
  [ "English Breakfast Sachet", "" ],
  [ "French Lemon Ginger Sachet", exclusion_name ],
  [ "Green Pomogranate Sachet", "" ],
  [ "Happy Sachet", "" ],
  [ "Mint Green Tea Sachet", "" ],
  [ "Pacific Coast Mint Sachet", exclusion_name ],
  [ "Tali's Masala Chai Sachet", "" ]
]
tea_tins = [
  [ "Apricot Escape Tin", exclusion_name ],
  [ "Bright Eyed Tin", exclusion_name ],
  [ "Dark Chocolate Peppermint Tin", "" ],
  [ "Earl Grey Crème Tin", "" ],
  [ "Egyptian Chamomile Tin", exclusion_name ],
  [ "English Breakfast Tin", "" ],
  [ "French Lemon Ginger Tin", exclusion_name ],
  [ "Green Pomogranate Tin", "" ],
  [ "Happy Tin", "" ],
  [ "Mint Green Tea Tin", "" ],
  [ "Pacific Coast Mint Tin", exclusion_name ],
  [ "Tali's Masala Chai Tin", "" ]
]

tea_sachets.each do |(name, exclusion)|
  component = Component.create(sku_prefix: "GFT",
    name:,
    status:
    :draft, subcategory:)
  Restriction.create(restrictable: assembly1, name: exclusion_name) if exclusion_name.present?
  LineItemOption.create(assembly_line_item: line_item1_1, option: component)
end

tea_tins.each do |(name, exclusion)|
  Component.create(sku_prefix: "GFT",
    name:,
    status:
    :draft, subcategory:)
  Restriction.create(restrictable: assembly1, name: exclusion_name) if exclusion_name.present?
end

component2_1 = Component.create(sku_prefix: "PKG", name: "Tea Sampler Box", status: :draft)
LineItemOption.create(assembly_line_item: line_item1_2, option: component2_1)

component3_1 = Component.create(sku_prefix: "PKG", name: "Tea Sampler Label", status: :draft)
LineItemOption.create(assembly_line_item: line_item1_3, option: component3_1)

assembly2 = Assembly.create(sku_prefix: "GFT", subcategory:, name: "Tea Sampler", status: :draft)
Restriction.create(restrictable: assembly1, name: exclusion_name)
line_item2_1 = AssemblyLineItem.create(assembly: assembly2, quantity: 4)

tea_sachets.select { |(name, exclusion)| exclusion.present? }.each do |(name, exclusion)|
  component = Component.find_by(name:, status: :draft)
  LineItemOption.create(assembly_line_item: line_item2_1, option: component)
end

line_item2_2 = AssemblyLineItem.create(assembly: assembly2, quantity: 1)
LineItemOption.create(assembly_line_item: line_item2_2, option: component2_1)
line_item2_3 = AssemblyLineItem.create(assembly: assembly2, quantity: 1)
LineItemOption.create(assembly_line_item: line_item2_3, option: component3_1)
