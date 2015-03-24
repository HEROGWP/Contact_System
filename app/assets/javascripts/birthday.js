

$('body').on('click', '.btn-month', function(e){
	e.preventDefault();
	var $checkbox = $(this).prev();
	var $form = $checkbox.parents('form');
	var form = $form[0];
	$checkbox.prop('checked', !$checkbox.prop('checked'));
	Turbolinks.visit(form.action+(form.action.indexOf('?') == -1 ? '?' : '&')+$(form).serialize());
});
