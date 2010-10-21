	
	var map;
	var bounds;

	$(document).ready(function() {
		
		$('select').sSelect();
		placeFooter();
		window.onresize = function(event) {
			placeBlueBackground();
		}
		
		$('body').css('background-color','#99B3CC');
		

		
		$.getJSON('/features.json',function(result){
			
			var bounds = new OpenLayers.Bounds();
			map = new OpenLayers.Map("explore_map",{ controls: [] });
			map.addControl(new OpenLayers.Control.Navigation({zoomWheelEnabled : false}));
			
			var cloudmade = new OpenLayers.Layer.CloudMade("CloudMade", {key: 'b1d79c55fe5a4ea1ab2095a5a583d926',styleId: 1});
			map.addLayer(cloudmade);
			var epsg4326 = new OpenLayers.Projection("EPSG:4326");
			var center = new OpenLayers.LonLat(-3.7003454,40.4166909).transform(epsg4326, map.getProjectionObject());
			map.setCenter(center, 5);

			
			var markers = new OpenLayers.Layer.Markers( "Markers" );
					map.addLayer(markers);
						
					var size = new OpenLayers.Size(32,36);
					var offset = new OpenLayers.Pixel(-(size.w/2), -(size.h));
					
					for (var i=0; i<result.length; i++) {
						var marker_lonlat = new OpenLayers.LonLat(result[i].lon,result[i].lat).transform(epsg4326, map.getProjectionObject());
						bounds.extend(marker_lonlat);
						var site_marker_image = new OpenLayers.Icon("/images/explore/marker.png",size,offset);
						result[i].count = i;
						var site_marker = new SiteMarker(marker_lonlat,site_marker_image, result[i]);
						markers.addMarker(site_marker);
					}
	
					map.zoomToExtent(bounds);
					if (map.getZoom()>15) {
						map.zoomTo(7);
					}
					panToCenter();

		});
		
		placeBlueBackground();
	});
	
	
	
	$.getDocHeight = function(){
	    return Math.max(
	        $(document).height(),
	        $(window).height(),
	        document.documentElement.clientHeight
	    );
	};
	
	
	function panToCenter() {
		var map_height = $('div#explore_map').height();
		map.pan(0,((map_height/2)-260));
	}
	
	
	function placeFooter() {
		$('#footer').css('top',$.getDocHeight()+'px');
	}
	
	function placeBlueBackground() {
		var map_height = $('div#explore_map').height();
		$('#blue_bkg').css('top',map_height-210+'px');
	}
	
	
	function zoomIn() {
		map.zoomIn();
	}
	
	
	function zoomOut() {
		map.zoomOut();
	}
