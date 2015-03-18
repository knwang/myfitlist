Fabricator(:planning) do
  weight { Faker::Number.number(2) }
end

Fabricator(:invalid_planning, from: Planning) do
  weight nil
end