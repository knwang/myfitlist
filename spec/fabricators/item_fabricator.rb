Fabricator(:item) do
  name { Faker::Lorem.characters(10) }
  duration { Faker::Number.number(2) }
  result { Faker::Number.number(2) }
  unit { Faker::Lorem.characters(4) }
end

Fabricator(:invalid_item, from: :item) do
  name nil
end