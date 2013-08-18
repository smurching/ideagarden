
$(function(){
	
	
	$(window).resize(function(){
		var filter_width = $('#filters').outerWidth();
		if(filter_width != 0){
		$('#header').css("width", $(document).width());
		// $('#test').html("<p>"+$('#wrapper').offset().left.toString()+"</p>");

		// $('#test2').html("<p>"+filter_width+"</p>");		


			if($(window).width()-filter_width > $('#wrapper').width()+40){
				var white_space = $(window).width()-filter_width-$('#wrapper').width();
				$('#wrapper').css("left", filter_width+white_space/2);
			}
			
			else{
				$('#wrapper').css({"left" : filter_width+40});				
			}
			
		}
	});
	
	$(window).resize();
		
});

$.fn.errorHighlight = function(){
	$(this).css({"border" : "1px solid rgba(183,213,121, 0.835294)", "box-shadow" : "0 0 8px rgba(183,213,121, 0.6)"  });;		
}

$.fn.errorMessage = function(message, dismiss_all){
	
	
	if(typeof(dismiss_all) === "undefined"){
		var dismiss_all = false;
	}
	
	
	var id = $(this).attr("id");
	var element = $(this);
	var error = document.getElementById(id+"_error");
 	if(error == null){ 		
 		
 		$('#wrapper').prepend("<p class = 'form_error' id = '"+id+"_error'>"+message+". Click to Dismiss."+
 				(dismiss_all ?  "<a class = 'dismiss_all' href='#'> Dismiss all</a>" : "")+
 				"<br/></p>");			
 		$(this).errorHighlight();
 		var offset = $(this).offset();
 		var border = parseInt($(this).css("borderWidth"));
		var error = document.getElementById(id+"_error"); 		
 		$(error).offset({top: offset.top+border, left: offset.left+border}).click(function(){
 			$(error).hide();
			element.focus();
 		});
	
 	}
	else{
		$(error).show();		
	} 				
}

