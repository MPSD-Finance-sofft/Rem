var accords_datatable;

$(document).on('turbolinks:load', function() {
  accords_datatable();
});

accords_datatable = function(){
	$('#accords-datatable').dataTable({
	    "processing": true,
	    "serverSide": true,
	    "ajax": {
	      "url": $('#accords-datatable').data('source')
	    },
	    "pagingType": "full_numbers",
	    "columns": [
			{
				"data": "id", 
				title: "Id",
				"render":  
					function ( data, type, row, meta ) { return '<a href="/accords/'+data+'">' + data + '</a>';}
			},
			{"data": "state", title: "Stav"},
			{"data": "created_at", title: "Datum vytvoření"},
	    ],
	   "language": {
            "lengthMenu": "_MENU_ počet zobrazených žádostí",
            "zeroRecords": "Nothing found - sorry",
            "info": "",
            "infoEmpty": "No records available",
            "infoFiltered": "(filtered from _MAX_ total records)"
        }
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
 	 });
}