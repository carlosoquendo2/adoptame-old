$(document).ready(function () {
    //chance cities
	$("#state").change(function() {
		$("#state option:selected").each(function() {
            state_id = $(this).val();
			intelli.post(intelli.config.ia_url + 'actions.json', {action: 'get-cities', state_id: state_id}, 
			function (response) {
                debugger;
				$("#city").empty();
				response.forEach(element => {
					$("#city").append(new Option(element.city, element.id));
				}); 
			});
		});
	});
});

function clearCities() {
    var cities = document.getElementById('state');
    while (cities.length() > o) {
        alert("Se limpiará el combo" + cities);
        cities.remove(cities.length - 1);
    }
}