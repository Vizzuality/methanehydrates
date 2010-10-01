$(document).ready(function() {
    
		$(function(){
				$.fn.supersized.options = {  
					startwidth: 936,  
					startheight: 1024,
					vertical_center: 1,
					slideshow: 0
				};
				$('#supersized').supersized(); 
		});
});