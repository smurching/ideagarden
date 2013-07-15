
$(function(){
	

	$(window).resize(function(){
		$('#header').css("width", $(document).width());
		// $('#test').html("<p>"+$('#wrapper').offset().left.toString()+"</p>");
		var filter_width = $('#filters').outerWidth();
		// $('#test2').html("<p>"+filter_width+"</p>");		


			if($(window).width()-filter_width > $('#wrapper').width()+40){
				var white_space = $(window).width()-filter_width-$('#wrapper').width();
				$('#wrapper').css("left", filter_width+white_space/2);
			}
			
			else{
				$('#wrapper').css({"left" : filter_width+40});				
			}
			
			
		
		
	});
	
	$(window).resize();
		
});

