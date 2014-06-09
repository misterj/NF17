<?php

namespace controller;

use library;

class General extends library\Controller
{
	public function accueil()
	{	
		$categories = array('Citadine', 'Berline', '4X4 SUV', 'Break', 'Pickup', 'Utilitaire');
		
		//Ajout des véhicules
		$vehicules['wv'] = array('numero_immatriculation' => 'wv', 'nom_categorie' => 'Utilitaire', 'marque' => 'Volkswagen', 'nom_modele' => 'Golf', 'nb_portes' => 2, 'boite_vitesse' => 'auto', 'puissance_fiscale' => '20ch', 'taille' => '4m', 'options' => array('antigravité'));
		$vehicules['johny'] = array('numero_immatriculation' => 'johny', 'nom_categorie' => 'Citadine', 'marque' => 'Peugeolt', 'nom_modele' => '206', 'nb_portes' => 4, 'boite_vitesse' => 'manuelle', 'puissance_fiscale' => '40ch', 'taille' => '8m', 'options' => array('klaxon allumez le feu', 'flammes sur le côté'));
		$vehicules['tractor'] = array('numero_immatriculation' => 'tractor', 'nom_categorie' => '4X4 SUV', 'marque' => 'Honda', 'nom_modele' => 'Tractooor', 'nb_portes' => 1, 'boite_vitesse' => 'manuelle', 'puissance_fiscale' => '150ch', 'taille' => '40m', 'options' => array('GPS', 'garde-boues'));
		
		foreach($vehicules as &$vehicule) {
			$vehicule['seuil_km'] = 250;
		}
		
		//Calcul des prix
		$vehicules['wv']['prix'] = '150';
		$vehicules['johny']['prix'] = '250';
		$vehicules['tractor']['prix'] = '300';
		
		//Sauvegarde des données du formulaire précédemment entrées
		$post['date_depart'] = !empty($_POST['date_depart']) ? $_POST['date_depart'] : '';
		$post['heure_depart'] = !empty($_POST['heure_depart']) ? $_POST['heure_depart'] : '';
		$post['date_retour'] = !empty($_POST['date_retour']) ? $_POST['date_retour'] : '';
		$post['heure_retour'] = !empty($_POST['heure_retour']) ? $_POST['heure_retour'] : '';
		$post['categorie'] = !empty($_POST['categorie']) ? $_POST['categorie'] : '';
		
		$this->addVars(array_merge($post, array('categories' => $categories, 'vehicules' => $vehicules)));
		return 'accueil.php';
	}
	
	public function recherche() 
	{
		$categories = array('Citadine', 'Berline', '4X4 SUV', 'Break', 'Pickup', 'Utilitaire');
	
		//Sauvegarde des données du formulaire précédemment entrées
		$post['date_depart'] = !empty($_POST['date_depart']) ? $_POST['date_depart'] : '';
		$post['heure_depart'] = !empty($_POST['heure_depart']) ? $_POST['heure_depart'] : '';
		$post['date_retour'] = !empty($_POST['date_retour']) ? $_POST['date_retour'] : '';
		$post['heure_retour'] = !empty($_POST['heure_retour']) ? $_POST['heure_retour'] : '';
		$post['categorie'] = !empty($_POST['categorie']) ? $_POST['categorie'] : '';
		
		//Ajout des véhicules
		if ($post['categorie'] == 'Utilitaire') 
		{
			$vehicules['wv'] = array('numero_immatriculation' => 'wv', 'nom_categorie' => 'Utilitaire', 'marque' => 'Volkswagen', 'nom_modele' => 'Golf', 'nb_portes' => 2, 'boite_vitesse' => 'auto', 'puissance_fiscale' => '20ch', 'taille' => '4m', 'options' => array('antigravité'));
			$vehicules['wv']['prix'] = '150';
		} 
		else if ($post['categorie'] == 'Citadine') 
		{
			$vehicules['johny'] = array('numero_immatriculation' => 'johny', 'nom_categorie' => 'Citadine', 'marque' => 'Peugeolt', 'nom_modele' => '206', 'nb_portes' => 4, 'boite_vitesse' => 'manuelle', 'puissance_fiscale' => '40ch', 'taille' => '8m', 'options' => array('klaxon allumez le feu', 'flammes sur le côté'));
			$vehicules['johny']['prix'] = '250';
		} 
		else if ($post['categorie'] == '4X4 SUV') 
		{
			$vehicules['tractor'] = array('numero_immatriculation' => 'tractor', 'nom_categorie' => '4X4 SUV', 'marque' => 'Honda', 'nom_modele' => 'Tractooor', 'nb_portes' => 1, 'boite_vitesse' => 'manuelle', 'puissance_fiscale' => '150ch', 'taille' => '40m', 'options' => array('GPS', 'garde-boues'));
			$vehicules['tractor']['prix'] = '300';
		} 
		else {
			$vehicules = array();
		}

		foreach($vehicules as &$vehicule) {
			$vehicule['seuil_km'] = 250;
		}
		
		$this->addVars(array_merge($post, array('categories' => $categories, 'vehicules' => $vehicules)));
		return 'recherche.php';
	}
	
	public function connexion()
	{
		$this->addVars(array('connexion_client' => true));
		return 'connexion.php';
	}
	
	public function inscription()
	{
		$this->addVars(array('type_client' => 'particulier'));
		return 'inscription.php';
	}
	
	public function liste_conducteurs()
	{
		return 'liste_conducteurs.php';
	}
	
	public function liste_agents()
	{
		return 'liste_agents.php';
	}
	
	public function liste_entreprises()
	{
		return 'liste_entreprises.php';
	}
}