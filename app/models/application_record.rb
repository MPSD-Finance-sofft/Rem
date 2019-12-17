class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def hash_diff(first, second)
     first.dup.delete_if { |k, v| second[k] == v }.merge!(second.dup.delete_if { |k, v| first.has_key?(k) })
  end

  def diff(record)
  	hash_diff(record.serializable_hash,self.serializable_hash)
  end

  def diff_without_nil(record, attributes=nil)
    diffrend = hash_diff(record.serializable_hash,self.serializable_hash)
    attributes = attributes.map{|a| [a,diffrend[a]]} unless attributes.nil?
    attributes ? r=Hash[*attributes.flatten] : r=diffrend
    r.compact.select{|a,b|  !b.to_s.empty?}
  end
end
