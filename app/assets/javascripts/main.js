$(function(){
	
		
	var visible_post = $('.featured_post_photo').filter(":visible")[0];	
	var height = $(visible_post).height();
	
	
	var width = $(visible_post).width();
	var aspect_ratio = height/width;
	
	var box_width = $('#featured_posts').width();
	var box_height = $('#featured_posts').height();
	var box_aspect_ratio = box_height/box_width;
	
	
	if (aspect_ratio > box_aspect_ratio ){
		$(visible_post).height(box_height);
	}
	else{
		$(visible_post).width(box_width);
	}

});



	
var current_posting = 0;
	

$(function(){
	
	var num_of_postings = $('.idea_posting').length;	
	$('.featured_left_caret').click(function(){
		prev_posting = (current_posting+num_of_postings-1)%num_of_postings;

		$("."+String(current_posting)).attr("class", String(current_posting)+" hidden idea_posting");
		$('.'+String(prev_posting)).attr("class", String(prev_posting)+" idea_posting");
		
		current_posting = prev_posting;	
		
		
	var visible_post = $('.featured_post_photo').filter(":visible")[0];	
	var height = $(visible_post).height();
	
	
	var width = $(visible_post).width();
	var aspect_ratio = height/width;
	
	var box_width = $('#featured_posts').width();
	var box_height = $('#featured_posts').height();
	var box_aspect_ratio = box_height/box_width;
	
	
	if (aspect_ratio > box_aspect_ratio ){
		$(visible_post).height(box_height);
	}
	else{
		$(visible_post).width(box_width);
	}
		

	});
	
	$('.featured_right_caret').click(function(){
		next_posting = (current_posting+1)%num_of_postings;
		

	
		// setting up variables
		var reference ="."+String(current_posting); 
		var next_reference = "."+String(next_posting);
		
		var width = $(reference).width();
		var box_width = $('#featured_posts').width();
		
		var i = 1;
		
		var current_text = $(reference).children("#featured_post_text").html();
		var next_text = $(next_reference).children("#featured_post_text").html();
		
		// hiding the current posting's gray text div
		$(reference).children("#featured_post_text").hide();
		
		// show empty gray filler div (added to make slide smoother)
		$('#featured_post_text_filler').show();
		
		// setting the next posting's gray text div's content to the current posting's 
		// so that the current posting's information is visible until after the current
		// posting has slid out of view. commented out because it doesn't work
		
		// $(next_reference).children("#featured_post_text").html(current_text);		
		// $(next_reference).children("#featured_post_text").css("margin-left", 0);
		
		// slides current posting out of view
		var interval = window.setInterval(function(){
		 
		 // how many pixels/ms to slide the div by
		 var increment = 9;
		 
		 i+=increment;
		 $(reference).css("margin-left", i);
		 
		 // after the posting has slid out of view
		 if(i > box_width){
			$(reference).attr("class", String(current_posting)+" hidden");		 
		 	clearInterval(interval);
			current_posting = next_posting;
			
			// shows next posting, hides gray filler div
			$(next_reference).attr("class", String(next_posting)).css("margin-left", 0);
			$('#featured_post_text_filler').hide();
			
			// unhide old post's text div
			$(reference).children("#featured_post_text").show();
			
 			// reset next posting's gray text div's conetents
 			// not necessary so it's commented out 			
			// $(next_reference).children("#featured_post_text").html(next_text);	

			
						 	
		 }
		 // console.log(i);
		 
		 
		}, 1);
		
		
		
		
				
		
		// console.log("next posting: "+String(next_posting));

		

		
		
		
		var visible_post = $('.featured_post_photo').filter(":visible")[0];	
		var height = $(visible_post).height();
	
	
		var width = $(visible_post).width();
		var aspect_ratio = height/width;
	
		var box_width = $('#featured_posts').width();
		var box_height = $('#featured_posts').height();
		var box_aspect_ratio = box_height/box_width;
	
	
	if (aspect_ratio > box_aspect_ratio ){
		$(visible_post).height(box_height);
	}
	else{
		$(visible_post).width(box_width);
	}
		
		
		
		
		
		
		
	});
	
	

});


function next_posting(num_of_postings, current_posting){
	console.log("in next posting");
	next_posting = (current_posting+1)%num_of_postings;
	
	
	$("."+current_posting.toString()).hide(); // attr("class", toString(current_posting)+" hidden");
	$('.'+next_posting.toString()).show();
	
}


