$(function(){
	if ($(".chzn-select").length > 0)
		$(".chzn-select").chosen({width: "500px"});

	if ($(".timepicker").length > 0)
		$(".timepicker").timepicker({
			minuteStep: 1,
			showSeconds: false,
			showMeridian: false
		});

	if ($("#add-contract form").length > 0)
		$("#add-contract form").validate();
});