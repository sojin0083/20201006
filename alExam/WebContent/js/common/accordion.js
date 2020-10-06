
$(function(){
	$('.list-w li a').click(function(){
		if($(this).find("+div").length){ 
			$(this).find("+div").stop().slideToggle().parent().siblings().find("div:visible").stop().slideUp();
		}
	});
});

