{if !empty($all_items)}
	<form method="post" id="cart-form">
		<div class="cart">
			{foreach $all_items as $cid => $categ}
				<div class="cart-categ">
					<div class="cart-categ__heading clearfix">
						{if $categ.image}
							<div class="cart-categ__image">{ia_image file=$categ.image type='thumbnail' class='img-responsive'}</div>
						{/if}
						<h3>{lang key="cart_categ_title_{$cid}"}</h3>
						<p>{lang key="cart_categ_description_{$cid}"}</p>
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
										{assign var='description' value="{lang key="cart_item_description_{$id}"}"}
										<tr>
											<td>{lang key="cart_item_title_$id"}</td>
											<td>{$item.age} {$item.age_type}</td>
											<td>{$item.state[0]}</td>
											<td>{$item.city[0]}</td>
											<td>{$item.gender}</td>
											<td>{$item.status}</td>
											<td><span class="fa fa-edit"></span></td>
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

	{ia_add_media files='js:_IA_URL_modules/adopta/js/frontend/order, css:_IA_URL_modules/adopta/templates/front/css/style'}
{else}
	<div class="alert alert-info">{lang key='no_items'}</div>
{/if}