class Unit < Dry::Struct
  Currency = Types::String.default('RUB'.freeze).enum('RUB', 'USD', 'EUR')

  attribute :name, Types::String
  attribute? :description, Types::String
  attribute :price, Types::Coercible::Float
  attribute :currency, Currency
  attribute :attachment do
    attribute :name, Types::String
    attribute :url, Types::String
  end
end
