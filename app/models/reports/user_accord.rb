module Reports::UserAccord
  def self.users_job_actity(user, date_from, date_to)
    return if user.blank?
    return if date_from.blank?
    return if date_to.blank?

    created_accords = Accord.created_by(user.id).start_created_at(date_from).end_created_at(date_to).pluck(:id)
    eborated_accords = eborated_accords_find(user, date_from, date_to)
    refuse_or_dowload_accords = refuse_or_dowload_accords_find(user, date_from, date_to)
    in_terain_accords = in_terrain_accords_find(user, date_from, date_to)
    to_sign_accords = to_sign_accords_accords_find(user, date_from, date_to)
    {created_accords: created_accords, eborated_accord: eborated_accords, refuse_or_dowload_accords: refuse_or_dowload_accords, in_terain_accords: in_terain_accords, to_sign_accords: to_sign_accords}
  end

  def self.eborated_accords_find(user, date_from, date_to)
    date_to = date_to.to_date.end_of_day
    versions = Version.where(whodunnit: user).where(item_type: "Accord").where(event: "update").where(created_at: date_from..date_to)
    attribut_changes(versions, 'state').select{|user_id, states, time, id|  states.last == 2}.map{|a| a.last}.uniq.select{|a| Accord.exists?(a)}
  end


  def self.refuse_or_dowload_accords_find(user, date_from, date_to)
    date_to = date_to.to_date.end_of_day
    versions = Version.where(whodunnit: user).where(item_type: "Accord").where(event: "update").where(created_at: date_from..date_to)
    attribut_changes(versions, 'state').select{|user_id, states, time, id|  states.last == 5 || states.last == 6}.map{|a| a.last}.uniq.select{|a| Accord.exists?(a)}
  end

  def self.in_terrain_accords_find(user, date_from, date_to)
    date_to = date_to.to_date.end_of_day
    versions = Version.where(whodunnit: user).where(item_type: "Accord").where(event: "update").where("created_at >= ?", date_from).where("created_at <= ?", date_to)
    attribut_changes(versions, 'state').select{|user_id, states, time, id|  states.last == 2}.map{|a| a.last}.uniq.select{|a| Accord.exists?(a)}
  end

  def self.to_sign_accords_accords_find(user, date_from, date_to)
    date_to = date_to.to_date.end_of_day
    versions = Version.where(whodunnit: user).where(item_type: "Accord").where(event: "update").where(created_at: date_from..date_to)
    attribut_changes(versions, 'state').select{|user_id, states, time, id|  states.last == 3}.map{|a| a.last}.uniq.select{|a| Accord.exists?(a)}
  end

  def self.attribut_changes(versions, attribute)
    versions.select{|a| a.object_changes && a.object_changes.include?(attribute)}.map{|a| [a.whodunnit, PaperTrail.serializer.load(a.object_changes)[attribute], a.created_at, a.item_id]}
  end
end

#attribut_changes("state").select{|user_id, states, time|  user_id == user.id && states.last == 'state_eleboration'}
#Version.where(whodunnit: User.first).where(item_type: "Accord").where(event: "update").where(created_at: date_from..date_to)

