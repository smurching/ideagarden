
 jQuery.fn.submitOnCheck = function(){
 this.find('input[type=checkbox]').click(function() {
    $(this).submit();
  });
  return this;
 }

 $(function() {
 $('#search_filters').submitOnCheck(); 
 $('#search_submit_tag').hide();
 $('body').prepend(
	<'div id ="login_filter"></div>');
 $('#login_filter').hide();   

 })();
  



/* jQuery.fn.submitOnCheck = ->
  @find('input[type=submit]').remove()
   @find('input[type=checkbox]').click ->
     $(this).submit()
   this
 
 jQuery ->
   $('#search_filters').submitOnCheck() */