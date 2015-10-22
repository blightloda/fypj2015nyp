//All function will activate when document is ready.

$(document).ready(function() {
			$.ajax({
				type: 'GET',
				url: 'index.aspx/getLiveCount',
				dataType: 'json',
				success: function(resp) {
					var value = resp;
					liveCount();
					$('#amount').html(resp);
				}
			});
			
			function liveCount(){
				var counter = setInterval(function() {
					var resp = parseInt($('#amount').html());
					resp++;
					$('#amount').html(resp);
				}, 200);
			};
});
