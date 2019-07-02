var find_vilage,find_number,find_street;

$(document).on('turbolinks:load', function() {
	find_vilage();	
	find_street();	
	find_number();	
  	$('#accords_realty').on('cocoon:after-insert', function() {
  		find_vilage();	
  		find_street();	
  		find_number();	
 	 });
});

find_vilage = function(){
	return $(".vilage_find").autocomplete({
    source: function(request, response) {
      var req;
      req = $.getJSON('/autocompleter_address/obec_find/', request);
      return req.success(function(data) {
        return response(data.map(function(o) {
          return {
            label: o.nazev_obce + ', ' + (o.nazev_casti_obce !== null ? o.nazev_casti_obce : '') + '[' + o.nazev_okresu + ']',
            value: o
          };
        }));
      });
    },
    select: function(event, ui) {
      $(this).data('popis', ui.item.label);
      $(this).data('obec', ui.item.value);
      return $(this).data('kod_obce', ui.item.value.kod_obce);
    },
    close: function(event, ui) {
      return $(this).val($(this).data('popis'));
    }
  });

}

find_street = function() {
  return $('.street_find').autocomplete({
    source: function(request, response) {
      var before_obec;
      before_obec = $(this.element).closest(".field").find('.vilage_find').data('kod_obce');
      return $.getJSON('/autocompleter_address/ulice_find/', {
        before_obec: before_obec,
        request: request
      }, response);
    }
  });
};

find_number = function() {
  return $('.number_find').autocomplete({
    source: function(request, response) {
      var before_obec, before_ulice;
      console.log(a =$(this.element).closest(".field").find('.vilage_find') )
      before_obec = $(this.element).closest(".field").find('.vilage_find').data("obec");
      before_ulice = $(this.element).closest(".field").find('.street_find').val();
      return $.getJSON('/autocompleter_address/cislo_find/', {
        before_obec: before_obec,
        before_ulice: before_ulice,
        request: request
      }, response);
    },
    close: function(event, ui) {
      
    }
  });
};