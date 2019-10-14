module Accords
  class IndexServices
    def initialize(accords,params)
     	@accords = accords
     	params.delete("utf8")
     	params.delete("commit")
     	params.delete("controller")
     	params.delete("action")
     	@params = params
    end

    def perform
    	@params.each do |key, value|
    		@accords = @accords.send(key,value) unless value.blank?
    	end unless @params.blank?
     	@accords
    end
  end

end
