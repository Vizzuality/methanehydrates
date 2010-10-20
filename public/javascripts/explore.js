	
	var map;

	$(document).ready(function() {
		
		$('select').sSelect();
		
		//get height and hack footer
		placeFooter();
		window.onresize = function(event) {
			placeBlueBackground();
		}
		
		$('body').css('background-color','#99B3CC');
		var latlng = new google.maps.LatLng(23.634501, -102.552784);
		var myOptions = {
	    zoom: 6,
	    center: latlng,
	    disableDefaultUI: true,
	    mapTypeId: google.maps.MapTypeId.TERRAIN,
			streetViewControl: false,
			backgroundColor: '#99B3CC'
	  }
	  map = new google.maps.Map(document.getElementById("explore_map"),myOptions);
		placeBlueBackground();
	});
	
	
	
	$.getDocHeight = function(){
	    return Math.max(
	        $(document).height(),
	        $(window).height(),
	        document.documentElement.clientHeight
	    );
	};
	
	
	function placeFooter() {
		$('#footer').css('top',$.getDocHeight()+'px');
	}
	
	function placeBlueBackground() {
		var map_height = $('div#explore_map').height();
		$('#blue_bkg').css('top',map_height-210+'px');
	}
