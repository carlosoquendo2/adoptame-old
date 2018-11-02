<?php
/******************************************************************************
 *
 * Subrion - open source content management system
 * Copyright (C) 2017 Intelliants, LLC <https://intelliants.com>
 *
 * This file is part of Subrion.
 *
 * Subrion is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Subrion is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Subrion. If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * @link https://subrion.org/
 *
 ******************************************************************************/

if (iaView::REQUEST_HTML == $iaView->getRequestType())
{
    //Obtener usuario logeado
	$loggedInUser = iaUsers::getIdentity();
	if($loggedInUser != null){

		//Obtener lista de todos las categorías activas
		$all_items = $iaDb->assoc(iaDb::ALL_COLUMNS_SELECTION, iaDb::convertIds(iaCore::STATUS_ACTIVE, 'status'), 'pet_categs');
	
		//Obteber todas las mascotas activas ordenadas por categoría
		$pet_condition = iaDb::convertIds(iaCore::STATUS_ACTIVE, 'status');
		$pet_condition = $pet_condition.' && member_id = '.$loggedInUser->id;
		$all_pets_actives = $iaDb->assoc(iaDb::ALL_COLUMNS_SELECTION, $pet_condition, 'pet_items');
	
		foreach ($all_items as $key => $categ)
		{
			//$all_items[$key]['items'] = $iaDb->assoc(iaDb::ALL_COLUMNS_SELECTION, "`cid` = {$key} && `member_id` = {$loggedInUser->id}", 'pet_items');
			if ($all_pets_actives != null) {
				foreach ($all_pets_actives as $id => $pet) {
					if ($pet['cid'] === "$key") {
						$all_items[$key]['items'][$id] = $pet;
					}
				}
			}
		}
		
		if($all_items != null){
			//variable con condicional de consulta de estado
			$states_condition = 'id IN ()';
			//variable con condicional de consulta de ciudades
			$cities_condition = 'id IN ()';
			//variable con condicional de consulta de miembro
			$owners_condition = 'id IN ()';
	
			$count = 0;
			for ($i=1; $i <= count($all_items); $i++) {
				foreach ($all_items[$i]['items'] as $key => $value) {
					$count++;
					$state = $value['state_id'];
					$city = $value['city_id'];
					$owner = $value['member_id'];
					if ($count == 1) {
						$states_condition = str_replace(')',$state.')',$states_condition);
						$cities_condition = str_replace(')',$city.')',$cities_condition);
						$owners_condition = str_replace(')',$owner.')',$owners_condition);
					}else {
						$states_condition = str_replace(')',','.$state.')',$states_condition);
						$cities_condition = str_replace(')',','.$city.')',$cities_condition);
						$owners_condition = str_replace(')',','.$owner.')',$owners_condition);
					}
				}
			}
	
			
			//variable con la lista de estados consultados
			$states = $iaDb->assoc('id, state', $states_condition, 'state');
			//variable con la lista de ciudades consultadas
			$cities = $iaDb->assoc('id, city', $cities_condition, 'city');
			//variable con la lista de nombres de usuarios de los miembros consultados
			$owners = $iaDb->assoc('id, email, username', $owners_condition, 'members');
	
			for ($i=1; $i <= count($all_items); $i++) {
				foreach ($all_items[$i]['items'] as $key => $value) {
					$all_items[$i]['items'][$key]['state'] = $states[$value['state_id']]['state'];
					$all_items[$i]['items'][$key]['city'] = $cities[$value['city_id']]['city'];
					$all_items[$i]['items'][$key]['owner_mail'] = $owners[$value['member_id']]['email'];
					$all_items[$i]['items'][$key]['owner_name'] = $owners[$value['member_id']]['username'];
				}
			}
		}
	
		if ($_POST)
		{
			$iaTransaction = $iaCore->factory('transaction');
	
			$gateways = $iaTransaction->getPaymentGateways();
	
			$transactionId = 0;
			if(isset($_POST['transaction_id']))
			{
				$transactionId = iaSanitize::sql($_POST['transaction_id']);
			}
	
			$iaView->title(iaLanguage::get('products_in_cart'));
			iaBreadcrumb::add(iaLanguage::get('order'), IA_URL . 'items/');
			iaBreadcrumb::replaceEnd(iaLanguage::get('products_in_cart'), IA_SELF);
			$iaView->assign('checkout', 1);
	
			$selected_products = [];
			$title = [];
	
			foreach ($_POST['cart_items'] as $categ => $product)
			{
				if ($product != '0')
				{
					$selected_products[$product] = $all_items[$categ]['items'][$product];
					$title[] = iaLanguage::get('cart_item_title_' . $product) . ' - ' . iaLanguage::get('cart_categ_title_' . $categ);
				}
			}
	
			$title = implode(', ', $title);
	
			$paymentId = $iaTransaction->create($title, $_POST['total'], 'cart_purchase', [], IA_URL . 'order/', 0, true);
	
			iaUtil::go_to(IA_URL . 'pay' . IA_URL_DELIMITER . $paymentId . IA_URL_DELIMITER);
		}
		else
		{
			$permission = true;
			$iaView->assign('urlEdit', "profile-mypets/pet/?id=");
			$iaView->assign('permission', $permission);
			$iaView->assign('all_items', $all_items);
		}
	}else {
		$permission = false;
		header('Location: '.IA_URL."login");
		$iaView->assign('permission', $permission);
	}

	$iaView->display('myPets');
}