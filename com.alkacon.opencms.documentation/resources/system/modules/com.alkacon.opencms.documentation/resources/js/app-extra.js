$('document').ready(function() {
    $('.page-nav').click(function (e) {
        e.stopPropagation(); 
     });
	$('.page-nav-btn').click(function(e) {
		$('.page-nav').show();
		e.stopPropagation();
		$('body').one('click', function() {
		    $('.page-nav').hide();
		});
	});
	$('.page-nav .close').click(function() {
		$('.page-nav').hide();
	})

});