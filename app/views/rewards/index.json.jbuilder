json.set! :data do
  json.array! @rewards do |reward|
    json.partial! 'rewards/reward', reward: reward
    json.url  "
              #{link_to 'Show', reward }
              #{link_to 'Edit', edit_reward_path(reward)}
              #{link_to 'Destroy', reward, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end