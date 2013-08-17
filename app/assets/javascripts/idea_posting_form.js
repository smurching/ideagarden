 $(function(){
 	if($('#wrapper').find("div.uneditable-input").length!=0){
 	$('.btn-file').css("width", "60").children().css({"height" : "20", "width" : "60"});
 	$('.btn-file > input').css({"width" : $('span.btn-file').outerWidth()}).offset({left : $('span.btn-file').offset().left});	
 	}

 });
 
 $(function(){
 	$('#photo_div').hide();
 	$('#photo').click(function(){
 		if($(this).attr("class")=="active"){
 			$('#photo_div').hide();
			$('a.fileupload-exists').click();
 		}
		else{
			$('#photo_div').show();
			
		}
 	});
 });


 
 // function for all the error messages that should show up
 $(function(){
 	
 	$('#form_post_container > input').on("click", function(event){
 		var text = $('span.fileupload-preview').text();
 		if(text.match(/jpe?g|png/) == null && text.length != 0){
 			event.preventDefault();	
 			$('a.fileupload-exists').click();
 			if($('#img_error').length==0){
 				$('#file_upload').before("<p class = 'form_error' id = 'img_error'>Make sure your picture is a png, jpg, or jpeg file. Click to Dismiss.<br/></p>");
 				$('#photo_div').errorHighlight();				 				
 			}
			else{
				$('#img_error').show();
			}
 			
 		}

		if($('#idea_posting_name').val().length<10){
			event.preventDefault();
			if($('#title_error').length==0){
				$('#idea_posting_name').before("<p class = 'form_error' id = 'title_error'>Make sure your title is at least 10 characters long. Click to Dismiss. <a class = 'dismiss_all' href='#'>Dismiss all</a></p>");
 				$('#idea_posting_name').errorHighlight();				
			}
			else{
				$('#title_error').show();
			}

		}
		
		if($('#idea_posting_pitch').val().length<10){
			event.preventDefault();
			$('#idea_posting_pitch').errorMessage("Make sure your pitch is at least 10 characters long");

		}
		
		
		if($('#idea_posting_description').val().length<10){
			event.preventDefault();
			if($('#description_error').length==0){
				$('#idea_posting_description').before("<p class = 'form_error' id = 'description_error'>Make sure your description is at least 10 characters long. Click to Dismiss.</p>");
 				$('#idea_posting_description').errorHighlight();				
			}
			else{
				$('#description_error').show();
			}

		}
		
		$('.form_error').css("width", "612").click(function(){$(this).hide()});
		$('a.dismiss_all').click(function(){
			$('.form_error').hide();
		});				
 	});

 });
 
 
 
 $(function(){
	$.watermark.options.className = 'watermark'; 	
	$.watermark.options.useNative = false;
 	$('#idea_posting_name').watermark("Got an Idea?", {className: "centered_watermark"});
 	$('#idea_posting_pitch').watermark("Pitch (10 char. minimum)", {className: "centered_watermark"});
 	$('#idea_posting_description').watermark("Description (10 char. minimum)", {className: "centered_watermark"});
 	
 	// when the idea posting form is clicked, change its watermark from "Got an idea?" to "Title (10 char. minimum)"
 	$('#idea_posting_name').on("click", function(){
 		$(this).watermark("Title (10 char. minimum)");
 	});
 	
 });
 
 
 $(function(){	
 	
 	// hides up-pointing caret arrow to start with
 	$('#caret_up').hide();
 	
 	// hides form except for "Got an idea?" input element
 	$('#new_idea_posting').find('div').hide();
 	$('#name_div').show();
 	


 	// offset the caret to an appropriate position. 

 	var o = $('#name_div').offset();
 	var div_width = $('#name_div').width();

 	
 	// $('.form_caret').css({"top" : $('#idea_posting_name').outerHeight()/2+10, "left" : $('#idea_posting_name').width()-3});
 	
 	// If the name div exists (if the user is logged in), position the idea_posting form carets,
 	// referring to them via .form_caret
 	
 	if(typeof(o) != "undefined"){
		var o = $('#idea_posting_name').offset();
 		var div_width = $('#idea_posting_name').width(); 		
 		$('.form_caret').offset({"left": o.left+div_width-5, "top" : o.top+7}); 	
 	}
 	else{
 		$(document).ready(function(){
		
 		});
 	}


 	
 	$('#caret_down, #idea_posting_name').on("click", function(){
 		

 			
 		// if the down caret was clicked, hide it and show the up caret
		$('#caret_down').hide();
		$('#caret_up').show(); 	
		
		// show rest of idea posting form		
		$('#new_idea_posting').find('div').show();
 		$('#idea_posting_name').watermark("Title (10 char. minimum)");				
		
		// hide the photo div
		if($('#photo').attr("class") != "active"){
			$('#photo_div').hide();
		}
		
		var o = $('#idea_posting_name').offset();
 		var div_width = $('#idea_posting_name').width(); 		
 		$('.form_caret').offset({"left": o.left+div_width-5, "top" : o.top+7}); 	
 		
 	});
 	
 	
 	$('#caret_up').on("click", function(){
 		

 				
		// if the up caret was clicked, hide it and show the down caret
		$('#caret_up').hide(); 			
		$('#caret_down').show();
		
		// hide the rest of the idea posting form and reset the watermark to "Got an idea?"					
		$('#new_idea_posting').find('div').hide();
 		$('#idea_posting_name').watermark("Got an Idea?");			
 		$('#name_div').show(); 		
 		
		var o = $('#idea_posting_name').offset();
 		var div_width = $('#idea_posting_name').width(); 		
 		$('.form_caret').offset({"left": o.left+div_width-5, "top" : o.top+7});  		
	
 	});
 	 	
 	 	
 	$('#filters').click(function(){
 		wrapper_o = $('#wrapper').offset();
 		
 		var num_of_loops = 0;
 		var filters_positioning = window.setInterval(function(){
			//console.log("in filters click");
 			var form_hidden = $('#pitch_div').attr("style");
 			
 			if(form_hidden.match(/none/) != null){
 				
 				num_of_loops +=1;
 				console.log(num_of_loops);
 				var o = $('#idea_posting_name').offset();
 				var div_width = $('#idea_posting_name').width(); 		
 				$('.form_caret').offset({"left": o.left+div_width-5, "top" : o.top+7});
 				
 				if(num_of_loops > 10){
 					clearInterval(filters_positioning); 					
 				}		
 			}
 			
 		}, 50);
		
		$(document).ready(function(){
 			$('#wrapper').offset({"left" : wrapper_o.left, "top" : wrapper_o.top});			
		});

 		
 	}); 	
 	
 	
 });
 
 
 
 
 $(function(){
 	var action = $('#new_idea_posting').attr("action"); 	
 	var now = jQuery.now();
 	$('#new_idea_posting').find('li').on("click", function(){
 		if(jQuery.now()-now>100){
 			// var changed = 0;
 			if($(this).attr("class") == "inactive"){
 				$(this).attr("class", "active");
 				// changed+=1;
 			}
 			else{
 				$(this).attr("class", "inactive");
 				// changed+=1;
 			}
 			// $('#wrapper').prepend("<p>"+changed.toString()+"</p>");
 		}
 		now = jQuery.now(); 	 
 		var params = "?"
 		$('#new_idea_posting').find("li.active").each(function(){
 			params += $(this).attr("id")+"=true&";
 		});
 		$('#new_idea_posting').attr("action", action+params); 				
 		});

 	
 });
  
