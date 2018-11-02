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
								<div class="row">
									{foreach $categ.items as $id => $item}
										{assign var='description' value="{lang key="pet_item_description_{$id}"}"}

										<div class="ia-item">
											{if $item.image}
											<div class="ia-item__image">
												<a href="#" data-toggle="modal" data-target="#modal_{$id}">
													{ia_image file=$item.image type='thumbnail' class='img-responsive'}
												</a>
											</div>
											{/if}
											<div class="ia-item__content">
											<h4 class="ia-item__title">{lang key="pet_item_title_{$id}"}</h4>
											
											{if $item.age}
												<span class="fa fa-paw"></span> {$item.age} {$item.age_type}
												</br>
											{/if}

											{if $item.state_id}
												<span class="fa fa-map-marker"></span> {$item.city}/{$item.state}
												</br>
											{/if}

											{if $item.member_id}
											<span class="fa fa-user"></span>
												{lang key='published_by'}
												<a href="{$smarty.const.IA_URL}member/{$item.member_id}.html" target="_blank">{$item.owner_name}</a>
												</br>
											{/if}

											{if $core.config.adoption_popup}
												<div class="ia-item__body">
												{$description|strip_tags|truncate:150:'...':true}
												</div>
											{else}
												<p>{$description}</p>
											{/if}

											<label class="cart-btn-buy">
												<input type="radio" class="js-cart-item" id="cart-item-{$id}" name="pet_items[{$cid}]" value="{$id}" data-cost="{$item.cost}" data-categ="{$cid}"><span>{lang key='request_adoption'}</span>
											</label>

											{if $core.config.adoption_popup}
												<button type="button" class="btn btn-primary cart-more-info" data-toggle="modal" data-target="#modal_{$id}">{lang key='more'}</button>

												<div class="modal fade" id="modal_{$id}" tabindex="-1" role="dialog">
													<div class="modal-dialog" role="document">
														<div class="modal-content">
															<div class="modal-body">
																<div class="media">
																	{if $item.image}
																		<div class="media-left">
																			<a href="{ia_image file=$item.image url=true type='large'}" rel="ia_lightbox[{lang key="pet_item_title_{$id}"}]">{ia_image file=$item.image type='thumbnail' class='media-object' width=120}</a>
																		</div>
																	{/if}
																	<div class="media-body">
																		<h4 class="media-heading">{lang key="pet_item_title_{$id}"}</h4>
																		{if $item.age}
																			<span class="fa fa-paw"></span> {$item.age} {$item.age_type}
																			</br>
																		{/if}

																		{if $item.state_id}
																			<span class="fa fa-map-marker"></span> {$item.city}/{$item.state}
																			</br>
																		{/if}

																		{if $item.member_id}
																		<span class="fa fa-user"></span>
																			{lang key='published_by'}
																			<a href="{$smarty.const.IA_URL}member/{$item.member_id}.html" target="_blank">{$item.owner_name}</a>
																			</br>
																		{/if}
																		<p>{$description}</p>
																	</div>
																</div>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
															</div>
														</div>
													</div>
												</div>
												</div>
											{/if}
										</div>

										{if $item@iteration % 3 == 0 && !$item@last}
											</div>
											<div class="row">
										{/if}
									{/foreach}
								</div>
							</div>
						{/if}
					</div>
				</div>
			{/foreach}
		</div>
	</form>
</div>

	{navigation aTotal=$pagination.total aTemplate=$pagination.template aItemsPerPage=$core.config.blog_number aNumPageItems=5}
 	{ia_add_media files='js:_IA_URL_modules/adopta/js/frontend/order, css:_IA_URL_modules/adopta/templates/front/css/style'}

{else}
	<div class="alert alert-info">{lang key='no_items'}</div>
{/if}