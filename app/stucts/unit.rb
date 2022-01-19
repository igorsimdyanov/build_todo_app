class Unit < Dry::Struct
  Currency = Types::String.enum('RUB', 'USD', 'EUR').default('RUB')

  attribute :name, Types::String
  attribute :description, Types::String.optional
  attribute :price, Types::Coercible::Float
  attribute :currency, Currency
end
