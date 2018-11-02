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

		$pet = $_GET['id'];
		if($pet != null){
			$item = $iaDb->assoc(iaDb::ALL_COLUMNS_SELECTION, 'id='.$pet, 'pet_items');
			$iaView->assign('item', $item[$pet]);
		}else {
			# code...
		}

		//list categories
		$allcategs = $iaDb->onefield('id', '', 0, 0, 'pet_categs');
		$categs = array();
		if ($allcategs != null) {
			foreach ($allcategs as $key => $value) {
				array_push($categs, $value);
			}
		}
		$categs || $iaView->setMessages(iaLanguage::get('cart_error_no_categs'));


		
		$permission = true;
		$iaView->assign('permission', $permission);
		$iaView->assign('categs', $categs);

	}else {
		$permission = false;
		header('Location: '.IA_URL."login");
		$iaView->assign('permission', $permission);
	}

	$iaView->display('pet');
}
