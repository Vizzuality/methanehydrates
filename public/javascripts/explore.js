
  var map;
  var bounds;
  var markers;
  var epsg4326;
  var reset = false;
	var global_index = 1000;

  var slider_water = 1500;
  var slider_hydrate = 1500;

  $(document).ready(function() {

    //Cover ul space with blue opaque background (header)
    var li_size = 0;
    $('div.inner_header ul li').each(function(index,element){
      li_size = li_size + $(element).width();
    });
    $('div.inner_header ul').css('background-position',(704-li_size-667) + 'px 0px');


    $('select').sSelect();
    $('body').css('background-color','#99B3CC');

    //Text Input effects
    $('input[type="text"]').click(function(ev){
      if ($(this).attr('value')=='All institutions') {
        $(this).attr('value','');
      }
    });
    $('input[type="text"]').focusout(function(ev){
      if ($(this).attr('value')=='') {
        $(this).attr('value','All institutions');
      }
    });


    $("div.water").slider({range: "min",value: 1500,min: 1,max: 1500,
      change: function(event, ui) {
        slider_water = ui.value;
        $('p.water').text('< '+slider_water);
        if (reset) {
          reset = false;
        } else {
          getSites();
        }
      }
    });

    $("div.hydrate").slider({range: "min", value: 1500, min: 1, max: 1500,
      change: function(event, ui) {
        slider_hydrate = ui.value;
        $('p.hydrate').text('< '+slider_hydrate);
        getSites();
      }
    });

    placeFooter();
    window.onresize = function(event) {
      placeBlueBackground();
    }

		var post_params = getUrlVars();
		var url = "/features.json" + ((post_params.page!=undefined && post_params.page!='')?('?page='+post_params.page):'');
    $.getJSON(url,function(result){
      map = new OpenLayers.Map("explore_map",{ controls: [], panDuration:0, panMethod:null });
      map.addControl(new OpenLayers.Control.Navigation({zoomWheelEnabled : false}));
      var cloudmade = new OpenLayers.Layer.CloudMade("CloudMade", {key: 'b1d79c55fe5a4ea1ab2095a5a583d926',styleId: 1});
      map.addLayer(cloudmade);
      epsg4326 = new OpenLayers.Projection("EPSG:4326");
      var center = new OpenLayers.LonLat(-3.7003454,40.4166909).transform(epsg4326, map.getProjectionObject());
      map.setCenter(center, 5);
      markers = new OpenLayers.Layer.Markers( "Markers" );
      map.addLayer(markers);
      showMarkers(result);
    });
    placeBlueBackground();
  });




  function showMarkers(result) {
    if (result.length!=0) {
      bounds = new OpenLayers.Bounds();
      var size = new OpenLayers.Size(32,36);
      var offset = new OpenLayers.Pixel(-(size.w/2), -(size.h));

      for (var i=0; i<result.length; i++) {
        var marker_lonlat = new OpenLayers.LonLat(result[i].lon,result[i].lat).transform(epsg4326, map.getProjectionObject());
        bounds.extend(marker_lonlat);
        var site_marker_image = new OpenLayers.Icon("/images/explore/marker.png",size,offset);
        var site_marker = new SiteMarker(marker_lonlat,site_marker_image, result[i]);
        markers.addMarker(site_marker);
      }

      map.zoomToExtent(bounds);
      if (map.getZoom()>9) {
        map.zoomTo(8);
      } else {
				map.zoomOut();
			}
      panToCenter();
    }
  }




  function getSites() {
    showLoader();
    var url = '/features.json?institution='+ $('select').attr('value') +
              '&water_depth='+ slider_water +
              '&hydrate_depth='+ slider_hydrate;
    var search_value = $('input[type="text"]').attr('value');
    url += (search_value!="All institutions" && search_value!='')?'&name_or_country='+search_value:'';
    $.getJSON(url,function(result){
      markers.clearMarkers();
      showMarkers(result);
      createSiteList(result);
      hideLoader();
    });
  }



  function createSiteList(result) {
    $('#site_list').html('');

    //Changing count sites
    if (result.length==0) {
      $('div.left h1').text('Viewing 0 Sites');
    } else if (result.length==1) {
      $('div.left h1').text('Viewing 1 Site');
    } else {
      $('div.left h1').text('Viewing '+result.length+' Sites');
    }

    if (result.length>0) {
      for (var i=0; i<result.length; i++) {
        var li_ = '<li class="'+ ((i==result.length-1)?'last':'') +'">'+
          '<div class="head">'+
            '<div class="image">'+
              '<p>'+result[i].id+'</p>'+
            '</div>'+
            '<div class="info">'+
              '<h2><a href="'+result[i].url+'">'+result[i].title+' - '+result[i].country+'</a></h2>'+
              '<p><span class="first">'+result[i].region+'</span><span>'+result[i].country+'</span></p>'+
            '</div>'+
          '</div>'+
          '<p class="des">'+result[i].description+'... <a href="'+result[i].url+'">Read more</a></p>'+
          '<div class="grey">'+
            '<div class="block">'+
              '<h4>PRIMARY INSTITUTION</h4>'+
              '<p>'+result[i].primary_institution_name+'</p>'+
            '</div>'+
            '<div class="block">'+
              '<h4>WATER DEPTH</h4>'+
              '<p>'+result[i].water_depth+'</p>'+
            '</div>'+
            '<div class="block">'+
              '<h4>HYDRATE DEPTH(mbsf)</h4>'+
              '<p>'+result[i].hydrate_depth+'</p>'+
            '</div>'+
          '</div>'+
        '</li>';
        $('#site_list').append(li_);
      }
    } else {
      var li_ = '<li class="no_results last"><p class="no_results">There are no results with this filters criterias. <a onclick="resetFilters()">Reset filters</a></p></li>';
      $('#site_list').append(li_);
    }


  }



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


  function showLoader() {
    $('img.loader').fadeIn();
  }

  function hideLoader() {
    $('img.loader').fadeOut();
  }

  function resetFilters() {
    reset = true;
    $('div.water').slider( "value" , 1500 );
    $('div.hydrate').slider( "value" , 1500 );
  }



	function getUrlVars() {
		var vars = [], hash;
		var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		for(var i = 0; i < hashes.length; i++)
		{
		    hash = hashes[i].split('=');
		    vars.push(hash[0]);
		    vars[hash[0]] = hash[1];
		}
		return vars;
	}

