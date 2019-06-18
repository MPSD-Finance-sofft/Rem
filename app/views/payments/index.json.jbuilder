json.set! :data do
  json.array! @payments do |payment|
    json.partial! 'payments/payment', payment: payment
    json.url  "
              #{link_to 'Show', payment }
              #{link_to 'Edit', edit_payment_path(payment)}
              #{link_to 'Destroy', payment, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end