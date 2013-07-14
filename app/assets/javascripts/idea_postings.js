
 jQuery.fn.submitOnCheck = function(){
 this.find('input[type=checkbox]').click(function() {
    $(this).submit();
  });
  return this;
 }
 
 jQuery.fn.submitSearchFilter = function(){
 	var filters = $('#filters').find('li.active');
	// $('#wrapper').prepend("<p>"+filters.length.toString()+"</p>"); 	
 	var search_params = "?";
 	filters.each(function(){
 		search_params+=$(this).attr("id")+"=true&";
 	});
	// $('#wrapper').prepend("<p>"+search_params+"</p>"); 	 	
 	
 	$.get("/search"+search_params, function(data){
 		var start = data.search('<div id = "start_of_results">');
 		var end = data.search('<div id = "end_of_results">');
 		$('#wrapper').html(data.slice(start, end));
 		// $('#wrapper').prepend("<div>"+data.length+", "+start+", "+end+"</div>");
 	});
 	
 }
 


 $(function() {
 $('#search_filters').submitOnCheck(); 
 $('#search_submit_tag').hide();
 $('body').prepend(
	'<div id ="login_filter"></div>');
 $('#login_filter').hide();   

 });
 
 $(function(){
 	var offset = $('#header').offset();
 	var top = $('#header').outerHeight()+offset.top;
 	$('#filters').css({"top": top+2, "height" : $(document).height()});
 	$('#dummy').css({"top": top-5, "left" : $('#filters').offset().left});
 	
 });
 

 $(function(){
 	var now = jQuery.now();
 	$('#filters').find('li').on("click", function(){
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
 			$(this).submitSearchFilter();
 		}
 		now = jQuery.now(); 	 		
 	});
 	
 });
 
 
 $(function(){
	$.watermark.options.className = 'watermark'; 	
	$.watermark.options.useNative = false;
 	$('#idea_posting_name').watermark("Got an Idea?", {className: "centered_watermark"});
 	$('#idea_posting_pitch').watermark("Pitch (10 char. minimum)", {className: "centered_watermark"});
 	$('#idea_posting_description').watermark("Description (10 char. minimum)", {className: "centered_watermark"});
 	$('#idea_posting_name').on("click", function(){
 		$(this).watermark("Title (10 char. minimum)");
 	});
 	
 });
 
 
 $(function(){
 	$('#new_idea_posting').find('div').hide();
 	$('#name_div').show();
 	$('#form_caret').show();
 	$('#idea_posting_name').one("click", function(){
			$('#new_idea_posting').find('div').show();		
 	});
 	
 	var o = $('#name_div').offset();
 	$('#form_caret').css({"top" :$('#idea_posting_name').outerHeight()/2-$('#form_caret').outerHeight()/2, "left" : $('#idea_posting_name').width()});
 	$('#name_div').css({"margin-left": "-17px"});
 	
 	$('#form_caret').val("▲");
 	
 	// $('#form_caret').on("click", function(){
 	//	if($('#form_caret').val()=="▼"){
	//		$('#new_idea_posting').find('div').show();	 			
 	//	}
 	//	else{
	//		$('#new_idea_posting').find('div').hide();
 	//		$('#name_div').show();
 	//		$('#form_caret').show();				  			
 	//	}
 		
 	//});
 	
 });
 
 
 
 $(function(){
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
 		$('#new_idea_posting').find("li").each(function(){
 			params += $(this).attr("id")+"=true&";
 		});
 	
 		$('#new_idea_posting').attr("action", "/idea_postings"+params); 				
 		});

 	
 });
  



/* jQuery.fn.submitOnCheck = ->
  @find('input[type=submit]').remove()
   @find('input[type=checkbox]').click ->
     $(this).submit()
   this
 
 jQuery ->
   $('#search_filters').submitOnCheck() */