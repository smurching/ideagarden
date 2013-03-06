# $(function(){
# $('.delete_pm_button').bind('click', false);
# $('.delete_pm_button').click(function(){
# 	$(this).unbind('click');
# 	$(this).before('<p>Are you sure? </p> <button id = "Yes"></button> ')
# });
# $('.delete_pm_button').attr('data-confirm', "false");	
# });


# $(function(){
# $('#private_message_recipient_ids').chosen();
# });



jQuery ->
	$('#private_message_user_tokens').tokenInput('/users.json', {theme: 'facebook', prePopulate: $('#private_message_user_tokens').data('load')});
	

# jQuery ->
#   $('.token-input-list').attr('class', 'token-input-list-facebook');
