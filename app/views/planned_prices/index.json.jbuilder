json.set! :data do
  json.array! @planned_prices do |planned_price|
    json.partial! 'planned_prices/planned_price', planned_price: planned_price
    json.url  "
              #{link_to 'Show', planned_price }
              #{link_to 'Edit', edit_planned_price_path(planned_price)}
              #{link_to 'Destroy', planned_price, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end