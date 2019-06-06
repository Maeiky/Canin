class chien {
	//Initialisation des variables
	private var maxFaim:Number = 100;
	private var faim:Number = 100;
	private var humeur:Number = 100;
	private var ejecter:Boolean = false;
	private var digestion:Number = 0;
	private var maxDigestion:Number = 0;
	private var tempsFache:Number = 30;
	public var age:Number = 0;
	private var miam:Number = 0;
	public var iniGrosseur:Number = 0;
	private var maxAge:Number = (10+random(10));
	private var tanne:Number = 0;
	private var energie:Number = 100;
	private var horloge:Number;
	private var chio:MovieClip;
	private var chioAll:MovieClip;
	private var dort:Boolean = false;
	private var maladie:Boolean = false;
	private var maxDort:Number = 0;
	private var maxVieMalade:Number = 0;
	/////////////////////////////////////////////
	/////////////////////////////////////////////
	/////////////////////////////////////////////
	function chien(posX:Number, plan:Number, numero:Number, grosseur:Number, race:String, caractere:String) {
		//Création du chio
		_level0.zoom.scene.attachMovie("Chien", "chien"+numero, plan+10000);
		//Initialisation des chemin
		chioAll = _level0.zoom.scene["chien"+numero];
		chio = _level0.zoom.scene["chien"+numero].chio;
		//Positionnement
		chioAll._x = posX;
		chio.plan = plan;
		//Grosseur
		iniGrosseur = grosseur;
		chio.grosseur = iniGrosseur;
		chio.numero = numero;
		chio.race = race;
		/////
		fInitialisation();
		horloge = setInterval(ticHorloge, 500, this);
		energie = 70+random(30);
		humeur = 70+random(30);
	}
	///////////////////////////////////////////////////
	////////////TEMPS/////////////////////////////////
	/////////////////////////////////////////////////
	public function ticHorloge(c:chien):Void {
		if (!(chio.aType == "Déféquer")) {
			c.setAge();
			c.setFaim();
			c.setHumeur();
			c.setTanne();
			c.setFaim();
			if (!(chio.aType == "Déféquer")) {
				c.setEnergie();
				c.flatte();
				c.jouer();
				c.rproprete();
				c.maladies();
				c.frappe();
			}
		}
	}
	function frappe() {
		chio.punchInt;
		if (chio.punchInt<199 and chio.punchInt>20) {
			chio.bType = "TresTriste";
			chio.yType = "Triste";
			chio.qType = "Soumis";
			humeur = -0.05;
		}
		if (chio.punchInt>200) {
			chio.bType = "Rage";
			chio.yType = "Fache";
			chio.rType = "Hasard";
			//chio.qType = "Normal";			
			humeur = -0.1;
		}
		if (chio.punchInt>800) {
			chio.yType = "Triste";
			chio.rType = "Fuire";
			chio.bType = "TresTriste";
			chio.qType = "Soumis";
			humeur = -0.2;
		}
		if (chio.aType == "Coucher" and chio.punchInt>10) {
			chio.aType = "Marche";
			maxDort = 0;
			chio.yDort = false;
		}
		trace(chio.rType);
	}
	function flatte() {
		trace("Flatte: "+chio.flateInt);
		trace("Humeur: "+humeur);
		if (chio.flateInt<2000 and chio.flateInt>0 and humeur<100) {
			humeur += 0.5;
		}
	}
	function jouer() {
		trace(chio.pJouer);
		if (chio.pJouer == true) {
			faim -= 0.1;
			if (energie>50) {
				chio.rType = "Jouer";
				if (energie<99.5) {
					energie -= 0.6;
				}
				if (humeur<99.5) {
					humeur += 0.8;
				}
				if (chio.sante<95) {
					if (chio.maladie == false) {
						chio.sante += 0.5;
					}
				}
			} else {
				if (chio.rType == "Jouer") {
					trace("fuckYou");
					chio.rType = "Suivre";
				}
			}
			if (faim<70) {
				chio.pJouer = false;
				chio.rType = "Manger";
			}
		}
	}
	function maladies() {
		if (chio.sante<40) {
			chio.maladie = true;
			chio.yType = "Malade";
			chio.qType = "Soumis";
		}
		if (chio.maladie == true) {
			maxVieMalade++;
			if (maxVieMalade>90) {
				trace('ton chien est mort par maladie');
				die();
			}
		} else {
			maxVieMalade = 0;
		}
	}
	function rproprete() {
		trace("Proprete: "+_level0.salete);
		trace("chio.sante un: "+chio.sante);
		if (humeur<-50) {
			humeur = -50;
		}
		if (_level0.salete>15000 and _level0.salete<=50000) {
			chio.sante -= 0.1;
			humeur -= 0.05;
		}
		if (_level0.salete>50000) {
			chio.sante -= 0.3;
			humeur -= 0.15;
		}
		if (_level0.salete>100000) {
			chio.sante -= 0.4;
			humeur -= 0.2;
		}
		if (_level0.salete<=10000) {
			if (chio.maladie == false) {
				if (chio.sante<100) {
					chio.sante += 0.1;
				}
				if (humeur<100) {
					humeur += 0.1;
				}
			}
		}
	}
	public function setAge():Void {
		if (chio.die == true) {
			die();
		}
		_level0.age.text = Math.floor(age);
		age += 0.005;
		if (age<=3) {
			chio.grosseur = iniGrosseur+age*5;
		}
		if (age>maxAge) {
			trace('ton chien est mort de vieillesse');
			die();
		}
	}
	public function setFaim():Void {
		trace("Faim:"+faim);
		if (dort == false) {
			if (faim<60) {
				humeur -= 0.1;
			}
			if (faim<50) {
				humeur -= 0.2;
			}
			if (faim<30) {
				humeur -= 0.4;
			}
		}
		if (faim>2 and faim<70) {
			trace("Ingerer: "+chio.nbrIngerer);
			if (ejecter == false) {
				chio.rType = "Mange";
			}
		}
		if (age<3) {
			miam = age*3+2;
		} else {
			miam = 11;
		}
		if (chio.nbrIngerer>=miam and !(chio.aType == "Déféquer")) {
			trace("Assez manger");
			if (ejecter == false) {
				maxDigestion = chio.nbrIngerer*7;
				if (maxDigestion>70) {
					maxDigestion = 70;
				}
				humeur += 10;
				chio.rType = "Suivre";
				chio.aType = "Marche";
				faim = 100;
				ejecter = true;
			}
		}
		if (ejecter == true) {
			digestion += 0.3;
			trace("Digestion: "+digestion);
			if (digestion>maxDigestion) {
				digestion = 0;
				chio.aType = "Déféquer";
				ejecter = false;
			}
		} else {
			if (dort == false) {
				faim -= 0.2;
			}
		}
		if (dort == false) {
			if (faim<50) {
				chio.sante -= 0.1;
			}
			if (faim<40) {
				chio.sante -= 0.1;
			}
			if (faim<30) {
				chio.sante -= 0.1;
			}
			if (faim<20) {
				chio.sante -= 0.1;
			}
		}
		if (faim<70 and (!(chio.rType == "Mange") or _level0.zoom.scene.NbrNouri == 0)) {
			humeur -= 0.2;
			if (random(faim/3)<3) {
				if (faim>60) {
					chio.jType = "Petit jappe";
				} else if (faim>40) {
					chio.jType = "Jappe";
				} else {
					chio.jType = "Jappe fort";
				}
			}
		}
		if (faim<0) {
			trace('ton chien est mort de faim');
			die();
		}
	}
	public function setHumeur():Void {
		if (humeur>0) {
			humeur -= 0.1;
		}
		if (humeur<40) {
			chio.yType = "Triste";
			chio.qType = "Normal";
			chio.bType = "Triste";
			if (humeur<20) {
				chio.bType = "TresTriste";
			}
		}
		if (humeur>50 and humeur<90) {
			if (age<3) {
				chio.yType = "Cute";
			} else {
				chio.yType = "Normal";
			}
			chio.qType = "Normal";
			chio.bType = "Normal";
		}
		if (humeur>90 and humeur<100) {
			if (age<3) {
				chio.yType = "Cute";
			} else {
				chio.yType = "Sur de lui";
			}
			chio.qType = "Joyeux";
			chio.bType = "Joyeux";
		}
	}
	public function setEnergie():Void {
		trace("Energie:"+energie);
		if (dort == false) {
			energie -= 0.1;
		}
		if (energie>70 and energie<100 and age<maxAge) {
			//chio.aType = "Cours";
			if (energie>90) {
				chio.vitAnim = 7;
			} else if (energie>80) {
				chio.vitAnim = 6;
			} else {
				chio.vitAnim = 5;
			}
		}
		if (energie>50 and energie<70 and age<maxAge) {
			chio.vitAnim = 4;
		}
		if (energie<50 and age<maxAge) {
			//chio.aType = "Assi";
			chio.vitAnim = 3;
			chio.yType = "Endormie";
		}
		if (energie<50 and Math.floor(random(energie/2)) == 2 and chio.yDort == false and chio.punchInt<10 and !(chio.rType == "Mange")) {
			chio.jType = "Baille";
		}
		if (energie<=45 and chio.punchInt<10) {
			trace("Energie: "+energie);
			dort = true;
			if (dort == true) {
				chio.aType = "Coucher";
				chio.rType = "";
				chio.qType = "Normal";
				chio.jType = '';
				dort = true;
				maxDort++;
			}
			if (maxDort>3 and random(4) == 1) {
				chio.yDort = true;
			}
			if (maxDort>40 and random(10) == 1) {
				dort = true;
				energie = 100;
				dort = false;
				if (age<3) {
					chio.yType = "Cute";
				} else {
					chio.yType = "Normal";
				}
				chio.bType = "";
				chio.rType = "Suivre";
				chio.aType = "Cours";
				chio.vitAnim = 4;
				maxDort = 0;
				chio.yDort = false;
			}
		}
		if (energie<0) {
			trace('ton chien est mort d\'épuisement');
			die();
		}
	}
	public function setTanne():Void {
		tanne -= 0.01;
		if (tanne>10) {
			chio.bType = "Rage";
		}
	}
	/////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////
	public function getAge():Void {
	}
	public function getFaim():Void {
	}
	function fInitialisation() {
		/* Initialisation du chien */
		//Les yeux
		chio.yType = "Cute";
		//L'animation
		chio.aType = "Assi";
		//Type de jappement
		//chio.jType = "Baille";
		//La queu
		//chio.qType = "Joyeux";
		//Les Oreilles
		chio.oType = "Normal";
		//La bouche
		chio.bType = "Joyeux";
		//Renifler
		chio.renifle = false;
		//Vit d'animation
		chio.vitAnim = 4;
		chio.rType = "Suivre";
	}
	public function die() {
		trace("DIE");
		chio.aType = "Meurt";
		chio.mourir = true;
		clearInterval(horloge);
		delete this;
	}
}
