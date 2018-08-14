var i = 0;	
function tik() {
	$.ajax({
		cache: false,
		success: function() {
			$('#answer_time').val(i++);
		}
	});
};

$(document).ready(function(){  
    tik();  
	setInterval('tik()',1000);  
});