
SiteMarker = OpenLayers.Class({
    

    icon: null,
    lonlat: null,
    events: null,
    map: null,

    initialize: function(lonlat, icon, info) {
        this.lonlat = lonlat;
        this.info = info;

        var newIcon = (icon) ? icon : OpenLayers.Marker.defaultIcon();
        if (this.icon == null) {
            this.icon = newIcon;
        } else {
            this.icon.url = newIcon.url;
            this.icon.size = newIcon.size;
            this.icon.offset = newIcon.offset;
            this.icon.calculateOffset = newIcon.calculateOffset;
        }
        this.events = new OpenLayers.Events(this, this.icon.imageDiv, null);
    },
    

    destroy: function() {
        // erase any drawn features
        this.erase();

        this.map = null;

        this.events.destroy();
        this.events = null;

        if (this.icon != null) {
            this.icon.destroy();
            this.icon = null;
        }
    },
    

    draw: function(px) {
				
				var me = this;
																			
				$(this.icon.imageDiv).children().hide();
				
				if (this.info.country == null) {
					$(this.icon.imageDiv).append('<a href="#" class="open" style="background:url('+this.icon.url+') no-repeat center 0;">'+this.info.id+'</a>'+
																				'<div class="infowindow">'+
																					'<a href="#" class="close"></a>'+
																					'<div class=""><a href="'+this.info.url+'"><img src="'+this.info.image_url+'" alt="'+this.info.title+'" title="'+this.info.title+'"/></a></div>'+
																					'<h1><a href="'+this.info.url+'">'+this.info.title+'</a></h1>'+
																					'<p><span>'+this.info.region+'</span></p>'+
																				'</div>');
						if (parseInt(this.info.region.length) > 26){
							$(this.icon.imageDiv).find('div.infowindow').addClass('long');
						}
				}
				else{
					$(this.icon.imageDiv).append('<a href="#" class="open" style="background:url('+this.icon.url+') no-repeat center 0;">'+this.info.id+'</a>'+
																				'<div class="infowindow">'+
																					'<a href="#" class="close"></a>'+
																					'<div class=""><a href="'+this.info.url+'"><img src="'+this.info.image_url+'" alt="'+this.info.title+'" title="'+this.info.title+'"/></a></div>'+
																					'<h1><a href="'+this.info.url+'">'+this.info.title+'</a></h1>'+
																					'<p><span class="first">'+this.info.region+'</span><span>'+this.info.country+'</span></p>'+
																				'</div>');
																				
						if (parseInt(this.info.region.length)+parseInt(this.info.country.length) > 26){
							$(this.icon.imageDiv).find('div.infowindow').addClass('long');
						}
				}
				
				
				$(this.icon.imageDiv).find('a.open').hover(function(ev){
				  $(this).css('z-index',global_index++);
				});
				

				if (this.info.image_url=="" || this.info.image_url==null) {
					$(this.icon.imageDiv).find('div.infowindow').find('div').remove();
					$(this.icon.imageDiv).find('div.infowindow').addClass('tiny');
				}
				
				$(this.icon.imageDiv).find('a.open').click(function(ev){
					ev.stopPropagation();
					ev.preventDefault();
					if (!$(me.icon.imageDiv).find('div').is(':visible')) {
						$('div.infowindow').hide();
						global_index++;
						$('div.infowindow').css('z-index',global_index);
						var position = map.getViewPortPxFromLonLat(me.lonlat);
						var move_y = 0;
						var move_x = 0;
						
						if (position.y<330) {
							move_y = -280 + position.y - 65;
						}
						
						if (position.x<125) {
							move_x = -125+position.x -30;
						}
						
						if (($('div#explore_map').width() - position.x)<125) {
							move_x = 125 - ($('div#explore_map').width() - position.x) + 30;
						}
						
						map.pan(move_x,move_y);
						$(me.icon.imageDiv).find('div').fadeIn('fast');
						
					}
				});
				
				$(this.icon.imageDiv).find('a.close').click(function(ev){
					ev.stopPropagation();
					ev.preventDefault();
					if ($(me.icon.imageDiv).find('div.infowindow').is(':visible')) {
						$('div.infowindow').fadeOut();
					}
				});
				
        return this.icon.draw(px);
    },


    erase: function() {
        if (this.icon != null) {
            this.icon.erase();
        }
    }, 


    moveTo: function (px) {
        if ((px != null) && (this.icon != null)) {
            this.icon.moveTo(px);
        }           
        this.lonlat = this.map.getLonLatFromLayerPx(px);
    },


    isDrawn: function() {
        var isDrawn = (this.icon && this.icon.isDrawn());
        return isDrawn;   
    },


    onScreen:function() {
        
        var onScreen = false;
        if (this.map) {
            var screenBounds = this.map.getExtent();
            onScreen = screenBounds.containsLonLat(this.lonlat);
        }    
        return onScreen;
    },
    

    inflate: function(inflate) {
        if (this.icon) {
            var newSize = new OpenLayers.Size(this.icon.size.w * inflate, this.icon.size.h * inflate);
            this.icon.setSize(newSize);
        }        
    },
    

    setOpacity: function(opacity) {
        this.icon.setOpacity(opacity);
    },


    setUrl: function(url) {
        this.icon.setUrl(url);
    },    


    display: function(display) {
        this.icon.display(display);
    },

    CLASS_NAME: "SiteMarker"
});



SiteMarker.defaultIcon = function() {
    var url = OpenLayers.Util.getImagesLocation() + "/explore/marker.png";
    var size = new OpenLayers.Size(21, 25);
    var calculateOffset = function(size) {
       return new OpenLayers.Pixel(-(size.w/2), -size.h);
    };

    return new OpenLayers.Icon(url, size, null, calculateOffset);        
};
    

