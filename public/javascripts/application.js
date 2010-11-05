	
	    var map;
	    var days;
	    var markers;
	    var epsg4326;
	
	    $(document).ready(function() {
	      // HOME
	      Cufon.replace('.cufon_handofsean');
	//Text Input effects
	    $('input[type="text"]').click(function(ev){
	      if ($(this).attr('value')=='Location, Country...') {
	        $(this).attr('value','');
	      }
	    });
	    $('input[type="text"]').focusout(function(ev){
	      if ($(this).attr('value')=='') {
	        $(this).attr('value','Location, Country...');
	      }
	    });
	
	        //Cover ul space with blue opaque background (header)
	        var li_size = 0;
	        $('div.inner_header ul li').each(function(index,element){
	          li_size = li_size + $(element).width();
	        });
	        $('div.inner_header ul').css('background-position',(704-li_size-667) + 'px 0px');
	
	        //If there is twitter block
	        if ($('div.twitter')[0]) {
	          var url = "http://search.twitter.com/search.json?q=vizzuality&rpp=5&callback=?";
	          $.getJSON(url,function(data){
			var dataSize = parseInt(data.results.length) - 1;
	            $.each(data.results, function(i, item) {
	              var str = "<li><div class='image'><img src=\""+item.profile_image_url+"\" alt='"+item.from_user+"' title='"+item.from_user+"'/></div><div class='text'><p>"+replaceURLWithHTMLLinks(item.text)+"</p></div></li>";
			  if (i == dataSize) {
				var str = "<li class='last'><div class='image'><img src=\""+item.profile_image_url+"\" alt='"+item.from_user+"' title='"+item.from_user+"'/></div><div class='text'><p>"+replaceURLWithHTMLLinks(item.text)+"</p></div></li>";
			  }
	              $("#tweets_list").append(str);
	            });
	          });
	        }
	
	
	        //If there is news block
	        if ($('div.news')[0]) {
	          var url = "http://pipes.yahoo.com/pipes/pipe.run?_id=67556470dc3cb5b71dc57020634ce192&_render=json&_callback=?";
	          $.getJSON(url,function(data){
	            $.each(data.value.items, function(i, item) {
	             var str = "<li><h5><a href='"+item.link+"' target='_blank'>"+item.title+"</a></h5><p>from "+ $.url.setUrl(item.link).attr("host") +"</p></li>";
	              $("#news_list").append(str);
	              return (i != 9);
	            });
	          });
	        }
	
	
	        //If there is a map
	        if ($('div#map')[0]) {
	          map = new OpenLayers.Map("map",{ controls: [] });
		  if (!$('div#map').hasClass('feature_map')){
			map.addControl(new OpenLayers.Control.Navigation({zoomWheelEnabled : false}));	
		  }          
	          var cloudmade = new OpenLayers.Layer.CloudMade("CloudMade", {key: 'b1d79c55fe5a4ea1ab2095a5a583d926',styleId: 1});
	          map.addLayer(cloudmade);
	          epsg4326 = new OpenLayers.Projection("EPSG:4326");
	          var center = new OpenLayers.LonLat(parseInt($('#longitude').text()),parseInt($('#latitude').text())).transform(epsg4326, map.getProjectionObject());
	          map.setCenter(center, 5);
	          markers = new OpenLayers.Layer.Markers( "Markers" );
	          map.addLayer(markers);
	
	          var size = new OpenLayers.Size(28,32);
	          var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
	          var icon = new OpenLayers.Icon('/images/common/marker.png', size, offset);
	          markers.addMarker(new OpenLayers.Marker(center,icon));
	        }
			
	        Galleria.loadTheme('/javascripts/galleria.classic.js');
		    // Initialize Galleria
		    $('.galleryStyle').galleria({thumbnails:false, preload: 2,autoplay:5000,transition:'fade',});
	
	        //---- CALENDAR
	        if ($('div.calendar')[0]) {
		  var dayIndex;
	          $('.calendar').datepicker({
	            onChangeMonthYear: function(year, month,inst){
	              showLoader();
	              setTimeout(function(ev){
	                $("td a").removeClass('ui-state-active');
	                $("td a").removeClass('ui-state-highlight');
	                $('td').removeAttr('onclick');
	              },0);
	
	              $.getJSON('/events.json?year='+year+'&month='+month,function(result){
	                for (var i=0; i<result.length; i++) {
	  				  dayIndex = result[i].day - 1;
	                  $("td a:eq("+dayIndex+")").addClass('ui-state-active');
	                  $("td a:eq("+dayIndex+")").attr('href',result[i].url);
	                }
	                hideLoader();
	              });
	            }
	          });
	
	          $('.calendar').append('<div class="bottom-navigator ui-corner-bottom"><a onclick="javascript:void $(\'a.ui-datepicker-prev\').trigger(\'click\');" class="prev"></a><a onclick="javascript:void $(\'a.ui-datepicker-next\').trigger(\'click\');" class="next"></a></div>');
	          $("td a").removeClass('ui-state-active');
	          $("td a").removeClass('ui-state-highlight');
	          $('td').removeAttr('onclick');
	
	          $('td a').livequery('click',function(ev){
	            if ($(this).attr('href')=="#"){
	              ev.stopPropagation();
	              ev.preventDefault();
	              return false;
	            }
	          });
	
	          var date = new Date();
	          $.getJSON('/events.json?year='+date.getFullYear()+'&month='+(date.getMonth()+1),function(result){
	            for (var i=0; i<result.length; i++) {
				dayIndex = result[i].day - 1;
	              $("td a:eq("+ dayIndex +")").addClass('ui-state-active');
	              $("td a:eq("+ dayIndex +")").attr('href',result[i].url);
	            }
	          });
	        }
	
	        // ---- END CALENDAR
			
		// To create partners list randomized
		if ($('ul#partners_list')[0]) {			
			// Deleting first class
			$('ul#partners_list li').first().removeClass('first');
			$('ul#partners_list').shuffle();
			// adding first class to the new element of list
			$('ul#partners_list li').first().addClass('first');
		}
		
		if($('div#about_right_column')[0]){
			$(window).scroll(function () {
				if ($(window.pageYOffset)[0] > 708) {
					$('div.about_right').css('position','fixed');
				}else {
					$('div.about_right').css('position','absolute');
				}
			});
		}
	    });
	
	
	    function replaceURLWithHTMLLinks(text) {
	      var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
	      return text.replace(exp,"<a href='$1' target='_blank'>$1</a>");
	    }
	
	
	    function showLoader() {
	      var height_calendar = $('div.calendar').height();
	      var position_calendar = $('div.calendar').position();
	      $('div.loader').height(height_calendar);
	      $('div.loader').css('top',position_calendar.top+'px');
	      $('div.calendar').css('opacity','0.2');
	      $('div.loader').show();
	
	    }
	
	
	    function hideLoader() {
	      $('div.calendar').css('opacity','1');
	      $('div.loader').hide();
	    }
	
	// Creating a new component randomized
	(function($){
	
		$.fn.shuffle = function() {
			return this.each(function(){
				var items = $(this).children().clone(true);
				return (items.length) ? $(this).html($.shuffle(items)) : this;
			});
		}
	
		$.shuffle = function(arr) {
			for(var j, x, i = arr.length; i; j = parseInt(Math.random() * i), x = arr[--i], arr[i] = arr[j], arr[j] = x);
			return arr;
		}
	
	})(jQuery);