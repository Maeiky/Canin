class Shop {
	// Initialisation des variables
	private var maxFaim:Number = 100;
	private var faim:Number = 50;
	private var humeur:Number = 51;
	private var sante:Number = 100;

	private var age:Number = 0;
	private var maxAge:Number = (5+random(10));
	private var tanne:Number = 0;
	private var energie:Number = 100;
	private var horloge:Number;
	private var chio:MovieClip;
	private var chioAll:MovieClip;
	////////////////////////////////////////////
	/////////////////////////////////////////////
	///////////////////////////////////////////
	function Shop(posX:Number, plan:Number, numero:Number, grosseur:Number, race:String, caractere:String) {
		//Création du chio
		_level0.zoom.scene.attachMovie("Chien", "chien"+numero,_level0.zoom.scene.getNextHighestDepth());
		//Initialisation des chemin
		chioAll = _level0.zoom.scene["chien"+numero];
		chio = _level0.zoom.scene["chien"+numero].chio;
		//Positionnement
		chioAll._x = posX;
		chio.plan = plan;
		//Grosseur
		chio.grosseur = grosseur;
		chio.numero = numero;
		chio.race = race;
		/////
		fInitialisation();
		horloge = setInterval(ticHorloge, 1000, this);
	}
	////////////TEMPS/////////////////////////////////
	public function ticHorloge(c:chien):Void {
		c.setAge();
		c.setFaim();
		
		c.setHumeur();
		c.setTanne();
		c.setFaim();
		c.setEnergie();
	}
	public function setAge():Void {
		age += 0, 0001;
		if (age>maxAge) {
			clearInterval(horloge);
			trace('ton chien est mort de vieillesse');
		}
	}
	public function setFaim():Void {
		faim -= 0, 1;
		if (faim<50) {
			sante -= 0, 2;
			humeur -= 0, 2;
		}
		if (faim<0) {
			clearInterval(horloge);
			trace('ton chien est mort de faim');
		}
	}
	
	public function setHumeur():Void {
		if (humeur>0) {
			humeur -= 0.1;
		}
	}
	public function setTanne():Void {
		if (tanne>0) {
			tanne -= 0, 001;
		}
	}
	public function setEnergie():Void {
		energie -= 0, 1;
		if (energie<0) {
			clearInterval(horloge);
			trace('tonchien est mort d\'épuisement');
		}
	}
	/////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////
	public function getAge():Void {
		
	}
	public function getFaim():Void {
	
	}
	function fInitialisation() {
		
		//Les yeux
		chio.yType = "Cute";
		//L'animation
		chio.aType = "Cours";
		//Type de jappement
		//chio.jType = "Baille";
		//La queu
		chio.qType = "Joyeux";
		//Les Oreilles
		chio.oType = "Normal";
		//La bouche
		chio.bType = "Joyeux";
		//Renifler
		chio.renifle = false;
		//Vit d'animation
		chio.rType = "Hasard";
		chio.vitAnim = 6;
	}

	public function die() {
		trace("DIE");
		chio.aType = "Meurt";
		chio.mourir = true;
		clearInterval(horloge);
		delete this;
	}
}