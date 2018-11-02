{if $permission}

	{if !empty($all_items)}
	<div class="tab-content">
		<form method="post" id="cart-form">
			<div class="cart">
				{foreach $all_items as $cid => $categ}
					<div class="cart-categ">
						<div class="cart-categ__heading clearfix">
							{if $categ.image}
								<div class="cart-categ__image">{ia_image file=$categ.image type='thumbnail' class='img-responsive'}</div>
							{/if}
							<h3>{lang key="pet_categ_title_{$cid}"}</h3>
							<p>{lang key="pet_categ_description_{$cid}"}</p>
						</div>

						<div class="cart-categ__content">
							{if !$categ.items}
								<div class="alert alert-info">{lang key="not_item"}</div>
							{else}
								<div class="cart-categ__items">
									<table id="user_data" class="table table-striped">
										<thead class="thead-dark">
											<tr>
												<th>{lang key="name"}</th>
												<th>{lang key="age"}</th>
												<th>{lang key="state"}</th>
												<th>{lang key="city"}</th>
												<th>{lang key="gender"}</th>
												<th>{lang key="status"}</th>
											</tr>
										</thead>
										<tbody>
										{foreach $categ.items as $id => $item}
											{assign var='description' value="{lang key="pet_item_description_{$id}"}"}
											<tr>
												<td>{lang key="pet_item_title_$id"}</td>
												<td>{$item.age} {$item.age_type}</td>
												<td>{$item.state}</td>
												<td>{$item.city}</td>
												<td>{$item.gender}</td>
												<td>{$item.status}</td>
												<td><a href="{$urlEdit}+{$item.id}"><span class="fa fa-edit"></span></a></td>
												<td><span class="fa fa-trash"></span></td>
											</tr>
										{/foreach}
										</tbody>
									</table>
								</div>
							{/if}
						</div>
					</div>
				{/foreach}
			</div>
		</form>
	</div>

		{ia_add_media files='js:_IA_URL_modules/shopping_cart/js/frontend/order, css:_IA_URL_modules/shopping_cart/templates/front/css/style'}
		{ia_add_media files='js:_IA_URL_modules/adopta/js/frontend/order, css:_IA_URL_modules/adopta/templates/front/css/style'}
	{else}
		<div class="alert alert-info">{lang key='no_items'}</div>
	{/if}
{else}
	<div class="alert alert-error">{lang key='not_access'}</div>
{/if}