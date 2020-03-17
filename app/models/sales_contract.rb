class SalesContract < ApplicationRecord
  has_paper_trail ignore: [:updated_at]
  include RemoveWhiteSpiceFromNumberInput::SalesContract
end
