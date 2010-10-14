		
		var map;
		

		$(document).ready(function() {

		    //Cover ul space with blue opaque background (header)
		    var li_size = 0;
		    $('div.inner_header ul li').each(function(index,element){
		      li_size = li_size + $(element).width();
		    });
		    $('div.inner_header ul').css('background-position',(704-li_size-528-135) + 'px 0px');



		    //If there is twitter block
		    if ($('div.twitter')[0]) {
		      var url = "http://search.twitter.com/search.json?q=vizzuality&rpp=5&callback=?";
		      $.getJSON(url,function(data){
		        $.each(data.results, function(i, item) {
		          var str = "<li><div class='image'><img src=\""+item.profile_image_url+"\" alt='"+item.from_user+"' title='"+item.from_user+"'/></div><div class='text'><p>"+replaceURLWithHTMLLinks(item.text)+"</p></div></li>";
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
					var latlng = new google.maps.LatLng($('#latitude').text(),$('#longitude').text());
					
					var myOptions = {
			      zoom: 6,
			      center: latlng,
			      disableDefaultUI: true,
			      mapTypeId: google.maps.MapTypeId.TERRAIN,
						streetViewControl: false,
						backgroundColor: 'white'
			    }
			    map = new google.maps.Map(document.getElementById("map"),myOptions);
					var image = new google.maps.MarkerImage('../images/common/marker.png',new google.maps.Size(28, 32),new google.maps.Point(0,0),new google.maps.Point(14, 32));
					var marker = new google.maps.Marker({position: latlng,map: map,icon: image});
		    }				

				
				
				//Gallery NivoSlider
				$('.slider').nivoSlider({controlNav:true});
				
				
				
				//Datepicker calendar
				$('.calendar').datepicker();
				$('.calendar').append('<div class="bottom-navigator ui-corner-bottom"><a onclick="javascript:void $(\'a.ui-datepicker-prev\').trigger(\'click\');" class="prev"></a><a onclick="javascript:void $(\'a.ui-datepicker-next\').trigger(\'click\');" class="next"></a></div>');
				
				
				//Background resize image
		    $(function(){
		        $.fn.supersized.options = {
		          startwidth: 1021,
		          startheight: 901,
		          vertical_center: 1,
		          slideshow: 0
		        };
		        $('#supersized').supersized();
		    });
		});


		function replaceURLWithHTMLLinks(text) {
		  var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
		  return text.replace(exp,"<a href='$1' target='_blank'>$1</a>");
		}