jQuery(function($){

	var container = document.querySelector('#gallery');

	imagesLoaded(container, function () {
		var msnry = new Masonry(container, {
			itemSelector: '.item',　
			isFitWidth: true,　
			columnWidth: 420,
		});
		setTimeout(function(){
			$('#loading').fadeOut(300);
			$('#gallery').addClass('on');
	    },1000);
	});
});