Ext.onReady(function()
{
	if (Ext.get('js-grid-placeholder'))
	{
		new IntelliGrid(
		{
			columns: [
				'selection',
				{name: 'title', title: _t('title'), width: 1, sortable: false},
				{name: 'description', title: _t('description'), width: 2, sortable: false},
				'status',
				'update',
				'delete'
			]
		});
	}

	grid.toolbar = Ext.create('Ext.Toolbar', {
        items: [
            {
                emptyText: _t('text'),
                name: 'text',
                listeners: intelli.gridHelper.listener.specialKey,
                width: 275,
                xtype: 'textfield'
            }, {
                displayField: 'title',
                editable: false,
                emptyText: _t('status'),
                id: 'fltStatus',
                name: 'status',
                store: grid.stores.statuses,
                typeAhead: true,
                valueField: 'value',
                xtype: 'combo'
            }, {
                emptyText: _t('owner'),
                listeners: intelli.gridHelper.listener.specialKey,
                name: 'owner',
                width: 150,
                xtype: 'textfield'
            }, {
                handler: function () {
                    intelli.gridHelper.search(grid);
                },
                id: 'fltBtn',
                text: '<i class="i-search"></i> ' + _t('search')
            }, {
                handler: function () {
                    intelli.gridHelper.search(grid, true);
                },
                text: '<i class="i-close"></i> ' + _t('reset')
            }]
    });
    grid.init();

    var searchStatus = intelli.urlVal('status');
    if (searchStatus) {
        Ext.getCmp('fltStatus').setValue(searchStatus);
        intelli.gridHelper.search(grid);
    }
});

$(function()
{
	//chance cities
	$("#state").change(function() {
		$("#state option:selected").each(function() {
			state_id = $(this).val();
			intelli.post(intelli.config.admin_url + '/actions/read.json', {action: 'custom-action', state_id: state_id}, 
			function (response) {
				cities = document.getElementById('city');
				$("#city").empty();
				$("#city").append(new Option('-- select --', 0));
				response.forEach(element => {
					$("#city").append(new Option(element.city, element.id));
				}); 
			});
		});
	});

	// Page content language tabs
	$('a[data-toggle="tab"]', '#js-content-fields').on('shown.bs.tab', function()
	{
		var lngCode = $(this).data('language');
		CKEDITOR.instances['description[' + lngCode + ']']
			|| intelli.ckeditor('description[' + lngCode + ']', {toolbar: 'Extended'});

		$('#js-active-language').val(lngCode);
	});
	$('a[data-toggle="tab"]:first', '#js-content-fields').trigger('shown.bs.tab');
});

function clearCities(cities) {
	while (cities.length() > o) {
		alert("Se limpiará el combo" + cities);
		cities.remove(cities.length-1);
	}
}