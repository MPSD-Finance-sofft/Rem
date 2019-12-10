module IndexFilter
  class IndexServices
    def initialize(object,params)
     	@object = object
     	params.delete("utf8")
     	params.delete("commit")
     	params.delete("controller")
     	params.delete("action")
        params.delete("template")
        params.delete("colums")
     	@params = params
    end

    def perform
    	@params.each do |key, value|
    		@object = @object.send(key,value) unless value.blank?
    	end unless @params.blank?
     	@object
    end
  end

end
