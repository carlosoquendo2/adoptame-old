<form method="post" enctype="multipart/form-data" class="sap-form form-horizontal">
	{preventCsrf}
	<input type="hidden" name="language" id="js-active-language">

	<div class="wrap-list">
		<div class="wrap-group">
			<div class="wrap-group-heading">
				<!-- Titulo sección -->
				<h4>{lang key='information'}</h4>
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

			<!-- Label esterilizado y opción de selección -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='sterilized'}</label>
				<div class="col col-lg-4">
					<select name="sterilized">
						<option value="1" {if isset($item.sterilized) && 1 == $item.sterilized}selected="selected"{/if}>{lang key='yes'}</option>
						<option value="0" {if isset($item.sterilized) && 0 == $item.sterilized}selected="selected"{/if}>{lang key='no'}</option>
					</select>
				</div>
			</div>

			<!-- Label esquema de vacunación y opción de selección -->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='complete_vaccination_scheme'}</label>
				<div class="col col-lg-4">
					<select name="vaccination">
						<option value="1" {if isset($item.vaccination) && 1 == $item.vaccination}selected="selected"{/if}>{lang key='yes'}</option>
						<option value="0" {if isset($item.vaccination) && 0 == $item.vaccination}selected="selected"{/if}>{lang key='no'}</option>
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
						{foreach $states as $key => $state}
							<option value="{$key}" {if isset($item.state_id) && $item.state_id == $key} selected="selected"{/if} {if isset($smarty.post.state_id) && $state == $smarty.post.state_id}selected{/if}>{$state.state}</option>
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
						{foreach $cities as $key => $city}
							<option value="{$key}" {if isset($item.city_id) && $item.city_id == $key} selected="selected"{/if} {if isset($smarty.post.city_id) && $city == $smarty.post.city_id}selected{/if}>{$city.city}</option>
						{/foreach}
					</select>
				</div>
			</div>
			
			<!--Nombre y descripción-->
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='name'} {lang key='field_required'}</label>
				<div class="col col-lg-4">
					<input type="text" name="title" value="{lang key=$item.name|escape:'html'}"></input>
				</div>
			</div>
			<div class="row">
				<label class="col col-lg-2 control-label">{lang key='description'}</label>
				<div class="col col-lg-4">
					<textarea rows="15" name="description">{lang key=$item.description|escape:'html'}</textarea>
				</div>
			</div>
		</div>

		<div class="form-actions inline">
			<button type="submit" name="save" class="btn btn-primary">{lang key='save'}</button>
		</div>
	</div>
</form>

{ia_add_media files='js:_IA_URL_modules/adopta/js/frontend/pet'}
{ia_add_media files='css:_IA_URL_modules/adopta/templates/front/css/style'}

{ia_add_js}
	
	//validate age
	$('#age').change(function(e) {
		var age = $(this).val();
		if(age < 1){
			$(this).val("0");
		}
    });
{/ia_add_js}