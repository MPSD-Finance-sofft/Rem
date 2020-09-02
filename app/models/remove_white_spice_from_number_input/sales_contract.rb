module RemoveWhiteSpiceFromNumberInput::SalesContract

  def amount=(value)
    self[:amount] = value.to_s.delete(" ")
  end

end
