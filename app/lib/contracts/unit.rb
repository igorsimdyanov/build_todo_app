# frozen_string_literal: true
module Contracts
  class Unit < Contracts::Application
    def self.call(options)
      new.call(options)
    end

    params do
      required(:name).filled(:string)
      optional(:description).maybe(:string)
      required(:price).value(:float)
      optional(:currency).maybe(:string)
      required(:attachments).array(:hash) do
        required(:name).filled(:string)
        required(:url).filled(:string)
      end
    end
  end
end
#      include Callable

unit = {
  name: 'MacBookPro',
  description: 'Описание',
  price: 200000.0,
  attachments: [
   { name: 'Внешний вид', url: '/apple/macbookpro/view.jpg' },
   { name: 'Вид сбоку', url: '/apple/macbookpro/side_view.jpg' }
  ]
}
# result = Contracts::Unit.call(unit)
