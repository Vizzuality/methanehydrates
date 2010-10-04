$(document).ready(function() {
    
		//Cover ul space with blue opaque background (header)
		var li_size = 0;
		$('div.inner_header ul li').each(function(index,element){
			li_size = li_size + $(element).width();
		});
		$('div.inner_header ul').css('background-position',(704-li_size-528-135) + 'px 0px');


		
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