$(function(){
$('.delete_pm_button').bind('click', false);
$('.delete_pm_button').click(function(){
	$(this).unbind('click');
	$(this).before('<p>Are you sure? </p> <button id = "Yes"></button> ')
});
$('.delete_pm_button').attr('data-confirm', "false");	
});
