class AccordsRealtyDecorator < Draper::Decorator
  delegate_all

  decorates_association :realty
	
end
