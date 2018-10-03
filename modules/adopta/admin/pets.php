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

class iaBackendController extends iaAbstractControllerModuleBackend
{
	protected $_name = 'pets';

	protected $_helperName = 'petitem';

	protected $_moduleName = 'adopta';

	protected $_gridColumns = ['id', 'order', 'status', 'update' => 1, 'delete' => 1];

	protected $_phraseAddSuccess = 'pet_item_added';
	protected $_phraseGridEntryDeleted = 'pet_item_deleted';
	protected $_phraseGridEntriesDeleted = 'pet_items_deleted';


	public function init()
	{
		$this->_path = IA_ADMIN_URL . 'adopta/' . $this->getName() . '/';
		$this->_template = 'pets';

		$iaPetItem = $this->_iaCore->factoryPlugin($this->getModuleName(), iaCore::ADMIN, $this->_helperName);

		$this->setHelper($iaPetItem);
		$this->setTable($iaPetItem::getTable());
	}

	protected function _setPageTitle(&$iaView, array $entryData, $action)
	{
		if (in_array($iaView->get('action'), [iaCore::ACTION_ADD, iaCore::ACTION_EDIT]))
		{
			$iaView->title(iaLanguage::get('pet_item_' . $iaView->get('action')));
		}
	}

	protected function _modifyGridResult(array &$entries)
	{
		$currentLanguage = $this->_iaCore->iaView->language;

		$this->_iaDb->setTable(iaLanguage::getTable());
		$titles = $this->_iaDb->keyvalue(['key', 'value'], "`key` LIKE('pet_item_title_%') AND `code` = '$currentLanguage'");
		$descriptions = $this->_iaDb->keyvalue(['key', 'value'], "`key` LIKE('pet_item_description_%') AND `code` = '$currentLanguage'");
		$this->_iaDb->resetTable();

		foreach ($entries as &$entry)
		{
			$entry['title'] = isset($titles["pet_item_title_{$entry['id']}"]) ? $titles["pet_item_title_{$entry['id']}"] : iaLanguage::get('empty');
			$entry['description'] = isset($descriptions["pet_item_description_{$entry['id']}"]) ? $descriptions["pet_item_description_{$entry['id']}"] : iaLanguage::get('empty');
		}
	}

	protected function _entryDelete($entryId)
	{
		return (bool)$this->getHelper()->delete($entryId);
	}

	protected function _preSaveEntry(array &$entry, array $data, $action)
	{
		if (empty($data['cid']))
		{
			$this->addMessage('pet_incorrect_categ');
		}

		$entry['cid'] = $data['cid'];

		iaUtil::loadUTF8Functions('ascii', 'validation', 'bad', 'utf8_to_ascii');

		$lang = [];
		$lang['title'] = $data['title'];
		$lang['description'] = $data['description'];

		foreach($this->_iaCore->languages as $code => $language)
		{
			if (empty($lang['title'][$code]))
			{
				$this->addMessage(iaLanguage::getf('error_lang_title', ['lang' => $language['title']]), false);
			}
			elseif (!utf8_is_valid($lang['title'][$code]))
			{
				$lang['title'][$code] = utf8_bad_replace($lang['title'][$code]);
			}

			if ($lang['description'][$code]  && !utf8_is_valid($lang['description'][$code]))
			{
				$lang['description'][$code] = utf8_bad_replace($lang['description'][$code]);
			}
		}

		$entry['name'] = "pet_item_title_".$this->_entryId;
		$entry['description'] = "pet_item_description_".$this->_entryId;
		$entry['status'] = $data['status'];
		$entry['gender'] = $data['gender'];
		$entry['age'] = $data['age'];
		$entry['age_type'] = $data['age_type'];
		$entry['member_id'] = $data['member_id'];
		
		if ($data['state']==0) {
			$this->addMessage('Seleccione un departamento');
		} else {
			$entry['state_id'] = $data['state'];
		}

		if ($data['city']==0) {
			$this->addMessage('Seleccione una ciudad');
		} else {
			$entry['city_id'] = $data['city'];
		}
		
		if (!$this->getMessages())
		{
			if (isset($_FILES['image']['error']) && !$_FILES['image']['error'])
			{
				try
				{
					$iaField = $this->_iaCore->factory('field');

					$path = $iaField->uploadImage($_FILES['image'], 1000, 750, 250, 250, 'crop');

					empty($entry['image']) || $iaField->deleteUploadedFile('image', $this->getTable(), $this->getEntryId(), $entry['image']);
					$entry['image'] = $path;
				}
				catch (Exception $e)
				{
					$this->addMessage($e->getMessage(), false);
				}
			}
		}

		return !$this->getMessages();
	}

	protected function _postSaveEntry(array &$entry, array $data, $action)
	{
		$id = $this->getEntryId();

		foreach ($this->_iaCore->languages as $code => $title)
		{
			iaLanguage::addPhrase('pet_item_title_' . $id, $data['title'][$code], $code, $this->getModuleName());
			iaLanguage::addPhrase('pet_item_description_' . $id, $data['description'][$code], $code, $this->getModuleName());
		}
	}

	protected function _assignValues(&$iaView, array &$entryData)
	{
		$iaUsers = $this->_iaCore->factory('users');

		$categs = $this->_iaDb->onefield(iaDb::ID_COLUMN_SELECTION, '', 0, 0, 'pet_categs');
		$categs || $iaView->setMessages(iaLanguage::get('cart_error_no_categs'));

		$states = $this->_iaDb->onefield(iaDb::ID_COLUMN_SELECTION, '', 0, 0, 'state');
		$states || $iaView->setMessages(iaLanguage::get('states_not_found'));

		if (!empty($entryData['state_id'])) {
			$state = $entryData['state_id'];
		} else {
			$state = 0;
		}
		$cities = $this->_iaDb->onefield(iaDb::ID_COLUMN_SELECTION, 'state='.$state, 0, 0, 'city');
		if($state != null){
			$cities || $iaView->setMessages(iaLanguage::get('cities_not_found'));
		}

		$owner = empty($entryData['member_id']) ? iaUsers::getIdentity(true) : $iaUsers->getInfo($entryData['member_id']);
		$entryData['owner'] = $owner['fullname'] . " ({$owner['email']})";
		$entryData['member_id'] = $owner['id'];

		$id = $this->getEntryId();

		$entryData['title'] = $this->_iaDb->keyvalue('`code`, `value`', "`key`='pet_item_title_{$id}'", iaLanguage::getTable());
		$entryData['description'] = $this->_iaDb->keyvalue('`code`, `value`', "`key`='pet_item_description_{$id}'", iaLanguage::getTable());
		
		$iaView->assign('categs', $categs);
		$iaView->assign('states', $states);
		$iaView->assign('cities', $cities);
	}

	//Update cities field
	public function _chanceCity()
	{
		$state = $_POST['id_state'];
		$cities = $this->_iaDb->onefield(iaDb::ID_COLUMN_SELECTION, 'state='.$state, 0, 0, 'city');
		$iaView->assign('cities', $cities);
	}
}