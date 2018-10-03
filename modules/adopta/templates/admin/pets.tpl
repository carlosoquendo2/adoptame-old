<form method="post" enctype="multipart/form-data" class="sap-form form-horizontal">
	{preventCsrf}
	<input type="hidden" name="language" id="js-active-language">

	<div class="wrap-list">
		<div class="wrap-group">
			<div class="wrap-group-heading">
				<!-- Titulo sección -->
				<h4>{lang key='options'}</h4>
			</div>
			<!-- Label Categoría y opción de selección -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='category'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					<select name="cid">
						<option value="">{lang key='_select_'}</option>
						{foreach $categs as $category}
							<option value="{$category}" {if isset($item.cid) && $item.cid == $category} selected="selected"{/if} {if isset($smarty.post.cid) && $category == $smarty.post.cid}selected{/if}>{lang key="pet_categ_title_"|cat:$category}</option>
						{/foreach}
					</select>
				</div>
			</div>
			
			<!-- Imagen del item -->
			<div class="row">
				<label class="col col-lg-2 control-label" for="input-image">{lang key='image'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					{if !empty($item.image)}
						<div class="input-group thumbnail thumbnail-single with-actions">
							<a href="{ia_image file=$item.image type='large' url=true}" rel="ia_lightbox">
								{ia_image file=$item.image}
							</a>

							<div class="caption">
								<a class="btn btn-small btn-danger js-cmd-delete-file" href="#" title="{lang key='delete'}" data-file="{$item.image}" data-item="pet_items" data-field="image" data-id="{$id}"><i class="i-remove-sign"></i></a>
							</div>
						</div>
					{/if}

					{ia_html_file name='image' id='input-image'}
				</div>
			</div>

			{*
			<div class="row">
				<label class="col col-lg-2 control-label" for="input-days">{lang key='days'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					<input type="text" name="days" id="input-days" value="{if isset($item.days)}{$item.days}{elseif isset($smarty.post.days)}{$smarty.post.days}{/if}">
				</div>
			</div>
			*}

			<!-- Label estado y opción de selección -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='status'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					<select name="status">
						<option value="active" {if isset($item.status) && iaCore::STATUS_ACTIVE == $item.status}selected="selected"{/if}>{lang key='active'}</option>
						<option value="inactive" {if isset($item.status) && iaCore::STATUS_INACTIVE == $item.status}selected="selected"{/if}>{lang key='inactive'}</option>
					</select>
				</div>
			</div>

			<!-- Label género y opción de selección -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='gender'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					<select name="gender">
						<option value="male" {if isset($item.gender) && iaCore::GENDER_MALE == $item.gender}selected="selected"{/if}>{lang key='male'}</option>
						<option value="female" {if isset($item.gender) && iaCore::GENDER_FEMALE == $item.gender}selected="selected"{/if}>{lang key='female'}</option>
					</select>
				</div>
			</div>

			<!-- Label edad, inpunt(number) y opción de selección -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='age'} {lang key='field_required'}</label>
				<div class="col col-lg-1">
					<input type="number" name="age" id="age" value="{if isset($item.age)}{$item.age|escape:'html'}{/if}">
				</div>
				<div class="col col-lg-2">
					<select name="age_type">
						<option value="months" {if isset($item.age_type) && iaCore::AGE_MONTHS == $item.age_type}selected="selected"{/if}>{lang key='months'}</option>
						<option value="years" {if isset($item.age_type) && iaCore::AGE_YEARS == $item.age_type}selected="selected"{/if}>{lang key='years'}</option>
					</select>
				</div>
			</div>

			<!-- Lista departamento -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='state'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					<select name="state" id="state">
						<option value="0">{lang key='_select_'}</option>
						{foreach $states as $state}
							<option value="{$state}" {if isset($item.state_id) && $item.state_id == $state} selected="selected"{/if} {if isset($smarty.post.state_id) && $state == $smarty.post.state_id}selected{/if}>{lang key="state_"|cat:$state}</option>
						{/foreach}
					</select>
				</div>
			</div>

			<!-- Lista ciudades -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='city'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					<select name="city" id="city">
						<option value="0">{lang key='_select_'}</option>
						{foreach $cities as $city}
							<option value="{$city}" {if isset($item.city_id) && $item.city_id == $city} selected="selected"{/if} {if isset($smarty.post.city_id) && $city == $smarty.post.city_id}selected{/if}>{lang key="city_"|cat:$city}</option>
						{/foreach}
					</select>
				</div>
			</div>

			{if isset($item.member_id)}
				<div class="row">
					<label class="col col-lg-2 control-label">{lang key='owner'} {lang key='field_required'}</label>

					<div class="col col-lg-4">
						<input type="text" autocomplete="off" id="js-owner-autocomplete" name="owner" value="{$item.owner|escape}" maxlength="255">
						<input type="hidden" name="member_id" id="member-id"{if !empty($item.member_id)} value="{$item.member_id}"{/if}>
					</div>
				</div>
			{/if}
		</div>

		<div class="wrap-group" id="js-content-fields">
			<div class="row">
				<ul class="nav nav-tabs">
					{foreach $core.languages as $code => $language}
						<li{if $language@iteration == 1} class="active"{/if}><a href="#tab-language-{$code}" data-toggle="tab" data-language="{$code}">{$language.title}</a></li>
					{/foreach}
				</ul>

				<div class="tab-content">
					{foreach $core.languages as $code => $language}
						<div class="tab-pane{if $language@first} active{/if}" id="tab-language-{$code}">
							<div class="row">
								<label class="col col-lg-2 control-label">{lang key='name'} {lang key='field_required'}</label>
								<div class="col col-lg-10">
									<input type="text" name="title[{$code}]" value="{if isset($item.title.$code)}{$item.title.$code|escape:'html'}{/if}">
								</div>
							</div>
							<div class="row js-local-url-field">
								<label class="col col-lg-2 control-label">{lang key='description'}</label>
								<div class="col col-lg-10">
									<textarea rows="30" name="description[{$code}]">{if isset($item.description.$code)}{$item.description.$code|escape:'html'}{/if}</textarea>
								</div>
							</div>
						</div>
					{/foreach}
				</div>
			</div>
		</div>

		<div class="form-actions inline">
			<button type="submit" name="save" class="btn btn-primary">{if iaCore::ACTION_EDIT == $pageAction}{lang key='save_changes'}{else}{lang key='add'}{/if}</button>
		</div>
	</div>
</form>

{ia_print_js files='ckeditor/ckeditor, _IA_URL_modules/adopta/js/admin/pets'}

{ia_add_js}
	//Updating owner
	$('#js-owner-autocomplete').typeahead(
    {
        source: function(query, process)
        {
            $.ajax(
            {
                url: intelli.config.ia_url + 'actions.json',
                type: 'get',
                dataType: 'json',
                data: { q: query, action: 'assign-owner' },
                success: function(response)
                {
                    objects = pets = [];
                    $.each(response, function(i, object)
                    {
                        pets[object.fullname] = object;
                        objects.push(object.fullname);
                    });

                    return process(objects);
                }
            })
        },
        updater: function(item)
        {
            $('#member-id').val(pets[item].id);
            return item;
        },
        matcher: function()
        {
            return true;
        }
    });

	//validate age
	$('#age').change(function(e) {
		var age = $(this).val();
		if(age < 1){
			$(this).val("0");
		}
    });
{/ia_add_js}