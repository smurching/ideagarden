$(function(){

	$.watermark.options.className = 'centered_watermark'; 	
	$.watermark.options.useNative = false;  
	$('.feedback_title').watermark("Title", {className: "centered_watermark"});  
	$('.feedback_body').watermark("Body", {className: "centered_watermark"});
	
});



$(function(){
 	$('#create_topic').off("click").on("click", function(event){
 		

	  	
	  	if($('#feedback_body').val().length<10){
			event.preventDefault();
			$('#feedback_body').errorMessage("Body must be at least 10 characters long");
 		}	 				
		
	  	if($('#feedback_title') != [] && $('#feedback_title').val().length < 10){
			event.preventDefault();
			$('#feedback_title').errorMessage("Title must be at least 10 characters long");
 		}	 				
				
	 		
 		$('.form_error').click(function(){$(this).hide()});
		$('a.dismiss_all').click(function(){
			$('.form_error').hide();
		});  	 		
  });
  
  
  });