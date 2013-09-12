
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


 $(function() {
 $('#search_filters').submitOnCheck(); 
 $('#search_submit_tag').hide();
 $('body').prepend(
	'<div id ="login_filter"></div>');
 $('#login_filter').hide();   

 });
 
 $(function(){
 	var offset = $('#header').offset();
 	
 	if(typeof(offset)!="undefined"){ 		
 		var top = $('#header').outerHeight()+offset.top;
 		$('#filters').css({"top": top+2, "height" : $(document).height()});
 		$('#dummy').css({"top": top-5, "left" : $('#filters').offset().left}); 	
 	}
 	
 });
 



/* jQuery.fn.submitOnCheck = ->
  @find('input[type=submit]').remove()
   @find('input[type=checkbox]').click ->
     $(this).submit()
   this
 
 jQuery ->
   $('#search_filters').submitOnCheck() */