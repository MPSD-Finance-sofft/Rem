json.set! :data do
  json.array! @repayments do |repayment|
    json.partial! 'repayments/repayment', repayment: repayment
    json.url  "
              #{link_to 'Show', repayment }
              #{link_to 'Edit', edit_repayment_path(repayment)}
              #{link_to 'Destroy', repayment, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end