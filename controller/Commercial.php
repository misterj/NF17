<?php

namespace controller;

use library;

class Commercial extends library\Controller
{
	public function __construct($application)
	{
		/*if(!isset($_SESSION['agent']))
			throw new \library\TommeException("You are not granted the rights to access this page\n");*/
			
		parent::__construct($application);
	}
	
	public function listeLocations()
	{
	
		return 'liste_locations_commercial.php';
	}
	
	public function location($num_contrat)
	{
		
		return 'location_commercial.php';
	}
}
