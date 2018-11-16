<?php
/******************************************************************************
 *
 *
 ******************************************************************************/
if (iaView::REQUEST_HTML == $iaView->getRequestType())
{
	//Obtener usuario logeado
	$loggedInUser = iaUsers::getIdentity();
	if($loggedInUser != null){
		
		if (isset($_POST['save'])) {
			if (empty($_GET['id'])) {
				//Se agrega una nueva mascota

			} else {
				//Se modifica la mascota

				/*Datos de la mascota*/
				$category = $_POST['cid'];
				$status = $_POST['status'];
				$gender = $_POST['gender'];
				$category = $_POST['age'];
				$category = $_POST['age_type'];
				$category = $_POST['state'];
				$category = $_POST['city'];

				/*Nombre y descripción de la mascota*/
				
			}
			
		}else {
			$pet = $_GET['id'];
			if($pet != null){
				$item = $iaDb->assoc(iaDb::ALL_COLUMNS_SELECTION, 'id='.$pet, 'pet_items');
				$iaView->assign('item', $item[$pet]);
			}else {
				# code...
			}
	
			//list categories
			$categs = $iaDb->onefield('id', '', 0, 0, 'pet_categs');
			$categs || $iaView->setMessages(iaLanguage::get('cart_error_no_categs'));
	
			//list states
			$states = $iaDb->assoc('id, state', '', 'state');
			
			//list cities
			$cities;
			if ($item[$pet]['city_id'] != null) {
				$cities = $iaDb->assoc('id, city', 'state='.$item[$pet]['state_id'], 'city');
			}
			
			$permission = true;
			$iaView->assign('permission', $permission);
			$iaView->assign('categs', $categs);
			$iaView->assign('states', $states);
			$iaView->assign('cities', $cities);
		}

		

	}else {
		$permission = false;
		header('Location: '.IA_URL."login");
		$iaView->assign('permission', $permission);
	}

	$iaView->display('pet');
}