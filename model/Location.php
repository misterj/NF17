<?php

namespace model;

use library;

class Location extends library\Model
{
	private $id_location;
	private $id_client;
	private $num_contrat;
	private $numero_immatriculation;
	private $_vehicule;
	private $_contratLoc;
	private $_montantPrevi;
	private $_validation;
	private $_confirmation;
	
	static private $foreignKey=null;
	
	public function __construct(){
		$this->_validation=false;
		$this->_confirmation=true;
	}
	
	public function getid_location(){
		return $this->id_location;
	}
	
	public function setid_location($id_location){
		$this->id_location=$id_location;
	}
	
	public function getid_client(){
		return $this->id_client;
	}
	
	public function setid_client($id_client){
		$this->id_client=$id_client;
	}
	
	public function getnum_contrat(){
		return $this->num_contrat;
	}
	
	public function setnum_contrat($num_contrat){
		$this->num_contrat=$num_contrat;
	}
	
	public function getnumero_immatriculation(){
		return $this->numero_immatriculation;
	}
	
	public function setnumero_immatriculation($numero_immatriculation){
		$this->numero_immatriculation=$numero_immatriculation;
	}
	
	public function getVehicule(){
		$mm=\library\ModelManager::getInstance();
		if(!isset($this->numero_immatriculation) || $this->numero_immatriculation==null)
			return;
		if(!isset($this->_vehicule))
			$this->_vehicule=$mm->getOneByNumero_immatriculation("Vehicule",$this->numero_immatriculation);
		return $this->_vehicule;
	}
	
	public function setVehicule($vehicule){
		$this->_vehicule=$vehicule;
	}
	
	public function getContrat(){
		$mm=\library\ModelManager::getInstance();
		if(!isset($this->num_contrat) || $this->num_contrat==null)
			return;
		if(!isset($this->_contratLoc))
			$this->_contratLoc=$mm->getOneByNum_contrat("Contrat_de_location",$this->num_contrat);
		return $this->_contratLoc;
	}
	
	public function setContrat($contrat){
		$this->contrat=$contrat;
	}
	
	public function getMontantPrevi(){
		//TODO CALCULER UN FUCKING MONTANT EN FONCTION DE NBJOURS ET DE VEHICULE
		//Multiplier la somme pourrie par le nb de jours
		return 50;
	}
	
	public function getPrimaryKey(){
		return "id_location";
	}
	
	public function get_validation($_validation){
		return $this->_validation;
	}
	
	public function set_validation($_validation){
		if($this->_validation==null)
			return false;
		$this->_validation=$_validation;
	}
	
	public function isValider(){
		return $this->_validation;
	}
	
	public function isConfirmer(){
		return $this->_confirmation;
	}
	
	public function setConfirmation(){
		$this->_confirmation=true;
	}
	
	public function isPasse(){
		//TODO 
		return false;
	}
	
	public function getFraisSupplementaires(){
		return $this->getContrat()->getFacture()->getMontant() - $this->getMontantPrevi();
	}
	
	public function getEtat(){
		if($this->isPasse())
			return "Passé";
		if($this->_validation)
			return "Validé";
		if($this->_confirmation)
			return "A valider";
		return "A Confirmer";
	}
	
	public function getForeignKeys(){
		if(self::$foreignKey==null){
			self::$foreignKey[0]=new \library\ForeignKey("Gerer","validation_finale_isdone","_validation","id_location");
		}
		return self::$foreignKey;
	}
}