module NotesHelper
	def color(color)
    	case color
	      	when 'red'
	          	"table-danger"
		    when 'green'
		        "table-success"
		    when 'yellow'
		        "table-warning"
		    else
		    	""
    	end
	end

end
