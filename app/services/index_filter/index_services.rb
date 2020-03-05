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
      params.delete("format")
      params.delete("year")
     	@params = params
    end

    def perform
    	@params.each do |key, value|
          value = value.reject(&:empty?) if value.is_a?(Array)
    		@object = @object.send(key,value) unless value.blank?
    	end unless @params.blank?
     	@object
    end
  end

end
