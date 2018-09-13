package{
	
	import flash.display.*;
	
	//used for events
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent; 
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	//used for keyboard input
	import flash.ui.Keyboard;
	
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	import fl.controls.SliderDirection;
	
	//used for sounds
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	//used for requesting resources
	import flash.net.URLRequest; 
	
	//used for timers
    import flash.utils.Timer; 
	
	//used for tweening
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	
	public class Main extends MovieClip{
		
		//constants
		
		//starting position the monster
		const monster_startx:int = -15;
		
		//starting position the monster
		const monster_starty:int = 125;
		
		//number of milliseconds in the timer
		const timerMilliSeconds = 1000;
		
		//variables
		
		//active boolean for when the game is running 
		var active:Boolean = false;
		
		//current Tower
		var currTower;    
		
		//current Tile
		var currTile:Tile1; 
		
		//barrel length for tank guns
		var barrelLength:Number = 3;
		var pcos:Number;
		var psin:Number;
		
		//random image number
		var randomimage:Number;
		
		//speed of the monster
		var monster_speed:Number = 1.5;   
		
		//number of monsters
		var monsterno:int = 10; 
		
		//number of monsters in play
		var monstersInPlay:int = 0;
		
		//current Gold
		var currGold:int = 500;
		
		//current Level
		var currLevel:int = 0; 
		
		//current stage
		var wave:int = 9;
		
		//lives
		var lives:int = 5;
		
		//non selectable tiles
		var nonSelectableTile:int;
		
		//number of raindrops
		var numberOfDrops:int = 200;
		
		//number of snowflakes
		var numberOfFlakes:int = 200;
		
		// links to other files
		
		//link to data file
		var gData:Data = new Data();
		
		//link to Waves file
		var gWave:Waves = new Waves();
		
		//link to SoundManager file
		var gSoundManager = new SoundManager();
		
		//link to String File
		var gStrings = new Strings();
		
		//Arrays
		
		//list of tiles on which towers cannot be placed
		var nonPlacableTiles:Array = new Array(); 
		
		//2D array for representing map
		var level:Array = new Array();             
		
		//list of monsters in the game
		var monsters:Array = new Array();          
		
		//list of bullets fired
		var bullets:Array = new Array();   
		
		//list of particles on stage
		var particles:Array = new Array();
		
		//list of weather elements on stage
		var weatherelements:Array = new Array();
		
		//list of towers placed
		var towers:Array = new Array();            
		
		//waypoints for controlling motion of monsters
		var waypoints_x:Array = new Array();       
		
		//waypoints for controlling motion of monsters
		var waypoints_y:Array = new Array();       
		
		//stores all the object's on the stage
		var stageObjects:Array = new Array();  

		private static var _instance:Main;
   		public static function get instance():Main { return _instance; }

		public function Main() {
			
			randomimage = Math.round(Math.random()*6);
			
			backgroundMC.gotoAndStop(randomimage);
			
			backgroundMC.addEventListener(Event.ENTER_FRAME, fadein);
			
			//set main instance
			_instance = this;
			
			//play background music 999 times with 1 second delay
			gSoundManager.playBackgroundMusic();
			
			gSoundManager.BGMTransform.volume = 1;
			
			playBtn.addEventListener(MouseEvent.MOUSE_UP,playBtnUpHandler);
			extrasBtn.addEventListener(MouseEvent.MOUSE_UP,extrasBtnUpHandler);
			optionsBtn.addEventListener(MouseEvent.MOUSE_UP,optionsBtnUpHandler);
			creditsBtn.addEventListener(MouseEvent.MOUSE_UP,creditsBtnUpHandler);
		}
		
		function fadein(e:Event){
    		if(backgroundMC.alpha >= 1){
       			 backgroundMC.removeEventListener(Event.ENTER_FRAME, fadein);
   			} else {
        		 backgroundMC.alpha +=0.02;
    		}
		}
		
		function playBtnUpHandler(event:MouseEvent){
			backgroundMC.removeEventListener(Event.ENTER_FRAME, fadein);
			playBtn.removeEventListener(MouseEvent.MOUSE_UP,playBtnUpHandler);
			extrasBtn.removeEventListener(MouseEvent.MOUSE_UP,extrasBtnUpHandler);
			optionsBtn.removeEventListener(MouseEvent.MOUSE_UP,optionsBtnUpHandler);
			creditsBtn.removeEventListener(MouseEvent.MOUSE_UP,creditsBtnUpHandler);
			
			//goto clear page
			gotoAndStop(2);
			
			belgiumBtn.addEventListener(MouseEvent.MOUSE_UP,belgiumBtnUpHandler);
			franceBtn.addEventListener(MouseEvent.MOUSE_UP,franceBtnUpHandler);
			tunisiaBtn.addEventListener(MouseEvent.MOUSE_UP,tunisiaBtnUpHandler);
			russiaBtn.addEventListener(MouseEvent.MOUSE_UP,russiaBtnUpHandler);
			mainMenuBtn.addEventListener(MouseEvent.MOUSE_UP,mainMenuBtnUpHandler);
		}
		
		function belgiumBtnUpHandler(event:MouseEvent){
			
			currLevel = 0;
			
			nonSelectableTile = 1;
			
			//goto clear page
			gotoAndStop(3);
			
			//initialize the game
			init();
			
			//hide the button
			nextwaveBtn.visible = false;
		}
		
		function franceBtnUpHandler(event:MouseEvent){
			
			currLevel = 1;
			
			nonSelectableTile = 1;
			
			//goto clear page
			gotoAndStop(3);
			
			//initialize the game
			init();
			
			//create rain
			makeItRain();
			
			//hide the button
			nextwaveBtn.visible = false;
		}
		
		function tunisiaBtnUpHandler(event:MouseEvent){
			
			currLevel = 2;
			
			nonSelectableTile = 4;
			
			//goto clear page
			gotoAndStop(3);
			
			//initialize the game
			init();
			
			//hide the button
			nextwaveBtn.visible = false;
		}
		
		function russiaBtnUpHandler(event:MouseEvent){
			
			currLevel = 3;
			
			nonSelectableTile = 6;
			
			//goto clear page
			gotoAndStop(3);
			
			//initialize the game
			init();
			
			//create snow
			makeItSnow();
			
			//hide the button
			nextwaveBtn.visible = false;
		}

		function init():void {
			
			// set up level
			gData.setUp();
			
			//set level to level int
			level = gData.levels[currLevel];
		    
			//waypoints are points from which the monster must turn
			waypoints_x = gData.waypoints_x[currLevel];
			waypoints_y = gData.waypoints_y[currLevel];
			
			//function for building the map
			BuildMap(level);   
			
			BtnTower.addEventListener(MouseEvent.MOUSE_OVER,showTowerBtnInfo);
			BtnTower2.addEventListener(MouseEvent.MOUSE_OVER,showTowerBtn2Info);
			BtnTower3.addEventListener(MouseEvent.MOUSE_OVER,showTowerBtn3Info);
			
			BtnTower.addEventListener(MouseEvent.MOUSE_OUT,hideTowerBtnInfo);
			BtnTower2.addEventListener(MouseEvent.MOUSE_OUT,hideTowerBtn2Info);
			BtnTower3.addEventListener(MouseEvent.MOUSE_OUT,hideTowerBtn3Info);
			
			BtnTower.addEventListener(MouseEvent.MOUSE_UP,TowerBtnUpHandler);
			BtnTower2.addEventListener(MouseEvent.MOUSE_UP,TowerBtn2UpHandler);
			BtnTower3.addEventListener(MouseEvent.MOUSE_UP,TowerBtn3UpHandler);
			
			restartBtn.addEventListener(MouseEvent.MOUSE_UP,restartBtnUpHandler);
			nextwaveBtn.addEventListener(MouseEvent.MOUSE_UP,nextwaveBtnUpHandler);
			mainMenuBtn2.addEventListener(MouseEvent.MOUSE_UP,mainMenuBtn2UpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
			
			//set active level to true
			active = true;
		}
		
		function makeItRain()
		{
			for (var i:int = 0; i < numberOfDrops; i++)
			{
				var TmpRain:Rain = new Rain();
				addChild(TmpRain);
 
 				weatherelements.push(TmpRain);
 
				TmpRain.SetInitialProperties();
			}
		}
		
		function makeItSnow()
		{
			for (var i:int = 0; i < numberOfFlakes; i++)
			{
				var TmpSnow:Snow = new Snow();
				addChild(TmpSnow);
 
 				weatherelements.push(TmpSnow);
 
				TmpSnow.SetInitialProperties();
			}
		}
		
		//display T34 Tank infomation when the mouse hovers over the T34 button
		function showTowerBtnInfo(event:MouseEvent){
			txtTankName.text = String("Tank: T34");
			txtTankRange.text = String("Range: 80");
			txtTankPrice.text = String("Gold: 200");
		}
		
		//display M6 Tank infomation when the mouse hovers over the M6 button
		function showTowerBtn2Info(event:MouseEvent){
			txtTankName.text = String("Tank: M6");
			txtTankRange.text = String("Range: 120");
			txtTankPrice.text = String("Gold: 400");
		}
		
		//display KV2 Tank infomation when the mouse hovers over the KV2 button
		function showTowerBtn3Info(event:MouseEvent){
			txtTankName.text = String("Tank: KV2");
			txtTankRange.text = String("Range: 60");
			txtTankPrice.text = String("Gold: 600");
		}
		
		//Hide Information when the mouse leaves the T34 button
		function hideTowerBtnInfo (event:MouseEvent){
			txtTankName.text = String("");
			txtTankRange.text = String("");
			txtTankPrice.text = String("");
		}
		
		//Hide Information when the mouse leaves the M6 button
		function hideTowerBtn2Info (event:MouseEvent){
			txtTankName.text = String("");
			txtTankRange.text = String("");
			txtTankPrice.text = String("");
		}
		
		//Hide Information when the mouse leaves the KV2 button
		function hideTowerBtn3Info (event:MouseEvent){
			txtTankName.text = String("");
			txtTankRange.text = String("");
			txtTankPrice.text = String("");
		}
		
		//Button for starting the next wave
		function nextwaveBtnUpHandler(event:MouseEvent){
			
			//set wave
			gWave.waves(wave);
			
			//set active to true
			active = true;
			
			//hide the button
			nextwaveBtn.visible = false;
		}
		
		//button for restarting the game while in the game
		function restartBtnUpHandler(event:MouseEvent){
			clearStage();
			resetValues();
			gotoAndStop(3);
			init();
			if(currLevel == 1)
			{
				makeItRain();
			}
			if(currLevel == 3)
			{
				makeItSnow();
			}
		}
		
		//button for going to the extras screen
		function extrasBtnUpHandler(event:MouseEvent){
			backgroundMC.removeEventListener(Event.ENTER_FRAME, fadein);
			gotoAndStop(7);
			historicalImages.gotoAndStop(1);
			spriteImage.gotoAndStop(1);
			tankDescription.text = gStrings.vk3006;
			mainMenuBtn.addEventListener(MouseEvent.MOUSE_UP,mainMenuBtnUpHandler);
			
			VK3006.addEventListener(MouseEvent.MOUSE_UP,VK3006BtnUpHandler);
			pz4ABtn.addEventListener(MouseEvent.MOUSE_UP,pz4ABtnUpHandler);
			pz4HBtn.addEventListener(MouseEvent.MOUSE_UP,pz4HBtnUpHandler);
			pz6AustBTiger2Btn.addEventListener(MouseEvent.MOUSE_UP,pz6AustBTiger2BtnUpHandler);
			e100Btn.addEventListener(MouseEvent.MOUSE_UP,e100BtnUpHandler);
			
			T34Btn.addEventListener(MouseEvent.MOUSE_UP,T34BtnUpHandler);
			M6Btn.addEventListener(MouseEvent.MOUSE_UP,M6BtnUpHandler);
			KV2Btn.addEventListener(MouseEvent.MOUSE_UP,KV2BtnUpHandler);
		}
		
		//button for going to the options screen
		function optionsBtnUpHandler(event:MouseEvent){
			backgroundMC.removeEventListener(Event.ENTER_FRAME, fadein);
			gotoAndStop(5);
			
			mainMenuBtn.addEventListener(MouseEvent.MOUSE_UP,mainMenuBtnUpHandler);
			
			musicSlider.value = gSoundManager.BGVolume / 10;
			musicSliderNumber.text = gSoundManager.BGVolume;
			musicSlider.addEventListener(SliderEvent.THUMB_DRAG,gSoundManager.ChangeBGMusicVolume);
			
			SFXSlider.value = gSoundManager.SFXVolume / 10;
			SFXSliderNumber.text = gSoundManager.SFXVolume;
			SFXSlider.addEventListener(SliderEvent.THUMB_DRAG,gSoundManager.ChangeSFXMusicVolume);
		}
		
		//button for going to the credit screen
		function creditsBtnUpHandler(event:MouseEvent){
			backgroundMC.removeEventListener(Event.ENTER_FRAME, fadein);
			gotoAndStop(6);
			mainMenuBtn.addEventListener(MouseEvent.MOUSE_UP,mainMenuBtnUpHandler);
		}
		
		function T34BtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(6);
			spriteImage.gotoAndStop(6);
			tankDescription.text = gStrings.t34;
		}
		
		function M6BtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(7);
			spriteImage.gotoAndStop(7);
			tankDescription.text = gStrings.m6;
		}
		
		function KV2BtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(8);
			spriteImage.gotoAndStop(8);
			tankDescription.text = gStrings.kv2;
		}
		
		function VK3006BtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(1);
			spriteImage.gotoAndStop(1);
			tankDescription.text = gStrings.vk3006;
		}
		
		function pz4ABtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(2);
			spriteImage.gotoAndStop(2);
			tankDescription.text = gStrings.pz4A;
		}
		
		function pz4HBtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(3);
			spriteImage.gotoAndStop(3);
			tankDescription.text = gStrings.pz4H;
		}
		
		function pz6AustBTiger2BtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(4);
			spriteImage.gotoAndStop(4);
			tankDescription.text = gStrings.pz6AustBTiger2;
		}
		
		function e100BtnUpHandler(event:MouseEvent){
			historicalImages.gotoAndStop(5);
			spriteImage.gotoAndStop(5);
			tankDescription.text = gStrings.e100;
		}
		
		function mainMenuBtnUpHandler(event:MouseEvent){
			gotoAndStop(1);
			randomimage = Math.round(Math.random()*6);
			backgroundMC.gotoAndStop(randomimage);
			backgroundMC.addEventListener(Event.ENTER_FRAME, fadein);
			resetValues();
			playBtn.addEventListener(MouseEvent.MOUSE_UP,playBtnUpHandler);
			extrasBtn.addEventListener(MouseEvent.MOUSE_UP,extrasBtnUpHandler);
			optionsBtn.addEventListener(MouseEvent.MOUSE_UP,optionsBtnUpHandler);
			creditsBtn.addEventListener(MouseEvent.MOUSE_UP,creditsBtnUpHandler);
		}
		
		function mainMenuBtn2UpHandler(event:MouseEvent){
			clearStage();
			clearWeather();
			stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
			gotoAndStop(1);
			randomimage = Math.round(Math.random()*6);
			backgroundMC.gotoAndStop(randomimage);
			backgroundMC.addEventListener(Event.ENTER_FRAME, fadein);
			resetValues();
			playBtn.addEventListener(MouseEvent.MOUSE_UP,playBtnUpHandler);
			extrasBtn.addEventListener(MouseEvent.MOUSE_UP,extrasBtnUpHandler);
			optionsBtn.addEventListener(MouseEvent.MOUSE_UP,optionsBtnUpHandler);
			creditsBtn.addEventListener(MouseEvent.MOUSE_UP,creditsBtnUpHandler);
		}
		
		//reset the variables to their default starting values
		function resetValues(){
			currGold = 500;
			if(currLevel == 0){
				currLevel = 0; 
				wave = 0;			
				lives = 5;
			}
			if(currLevel == 1){
				currLevel = 1; 
				wave = 0;			
				lives = 5;	
			}
			if(currLevel == 2){
				currLevel = 2; 
				wave = 0;			
				lives = 5;
			}
			if(currLevel == 3){
				currLevel = 3;
				wave = 0;			
				lives = 5;
			}
		}
		
		//this function will build the map
		function BuildMap(level):void{
			for(var i:int =0; i < level.length ; ++i){  
			
				//two loops are needed for accessing elements of a 2D array
				for(var j:int =0; j < level[i].length ; ++j){ 
					var tmpTile:Tile1 = new Tile1();
			        tmpTile.x = j*50;
			        tmpTile.y = i*50;
			        addChild(tmpTile);
					stageObjects.push(tmpTile);
					tmpTile.gotoAndStop(level[i][j]+1); 
					
					//add the tile to the nonPlacableTiles list if towers
					if(level[i][j]==nonSelectableTile)     
					
					//cannot be placed on it
					nonPlacableTiles.push(tmpTile);            
					tmpTile.addEventListener(MouseEvent.ROLL_OVER,TurnOnTile);
					tmpTile.addEventListener(MouseEvent.ROLL_OUT,TurnOfTile);
				}
			}
		}
		
		//this function is called when mouse is rolled over the tile
		function TurnOnTile(event:MouseEvent){
			currTile = event.currentTarget as Tile1;
			if(checkPlacable(currTile) && currTower != null){
				currTile.gotoAndStop(3);
			}
		}
		
		//this function is called when mouse is rolled out of the tile
		function TurnOfTile(event:MouseEvent){
			var prevTile = event.currentTarget as Tile1;
			if(prevTile.currentFrame == 3){
				if(currLevel == 0 || currLevel == 1)
				{
					prevTile.gotoAndStop(1);
				}
				else if(currLevel == 2)
				{
					prevTile.gotoAndStop(4);
				}
				else if(currLevel == 3)
				{
					prevTile.gotoAndStop(6);
				}
			}
		}
		
		//this function clears the stage
		function clearStage():void{
			for(var i:int = 0; i < stageObjects.length; ++i){
				if(stageObjects[i] != null){
					removeChild(stageObjects[i]);
					stageObjects[i] = null;
				}
			}
			
			//removes all towers
			for(var i:int = 0; i < towers.length; ++i){
				if(towers[i] != null){
					removeChild(towers[i]);
					towers[i] = null;
				}
			}
			
			//removes all towers
			for(var i:int = 0; i < monsters.length; ++i){
				if(monsters[i] != null){
					removeChild(monsters[i]);
					monsters[i] = null;
				}
			}
			
			//removes all bullets
			for(var i:int = 0; i < bullets.length; ++i){
				if(bullets[i] != null){
					removeChild(bullets[i]);
					bullets[i] = null;
				}
			}
			
			//removes all particles
			for(var i:int = 0; i < particles.length; ++i){
				if(particles[i] != null){
					removeChild(particles[i]);
					particles[i] = null;
				}
			}
			
			//remove current tower object
			if(currTower != null){
				removeChild(currTower);
		    	currTower = null;
			}
			
			//clear arrays
			stageObjects.splice(0);
			nonPlacableTiles.splice(0);
			monsters.splice(0);
			towers.splice(0);
			bullets.splice(0);
			particles.splice(0);
		}
		
		function clearWeather():void{
			
			//removes all weather elements
			for(var i:int = 0; i < weatherelements.length; ++i){
				if(weatherelements[i] != null){
					removeChild(weatherelements[i]);
					weatherelements[i] = null;
				}
			}
		}
		
		//this function creates an instance of a Tiger 2
		function createMonster(xpos:int,ypos:int):void{
			
			//add tiger II to tmp monster
			var tmpMonster = new Monster();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			
			//add the current monster to the list of monsters			
			monsters.push(tmpMonster);  
		}
		
		//this function creates an instance of a Panzer 4a
		function createMonster2(xpos:int,ypos:int):void{
			
			//add panzer 4 (early) to tmp monster
			var tmpMonster = new Monster2();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			
			//add the current monster to the list of monsters			
			monsters.push(tmpMonster); 
		}
		
		//this function creates an instance of a Panzer 4h
		function createMonster3(xpos:int,ypos:int):void{
			
			//add panzer 4 (late) to tmp monster
			var tmpMonster = new Monster3();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			
			//add the current monster to the list of monsters			
			monsters.push(tmpMonster);  
		}
		
		//this function creates an instance of a VK 30.60
		function createMonster4(xpos:int,ypos:int):void{
			
			//add VK prototype to tmp monster
			var tmpMonster = new Monster4();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			
			//add the current monster to the list of monsters
			monsters.push(tmpMonster);  
		}
		
		//this function creates an instance of a E100
		function createMonster5(xpos:int,ypos:int):void{
			
			//add E100 to tmp monster
			var tmpMonster = new Monster5();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			
			//add the current monster to the list of monsters
			monsters.push(tmpMonster);  
		}
		
		//this function checks if a tower can be placed on a tile
		function checkPlacable(tmpTile:Tile1):Boolean {
			for(var i:int = 0; i<nonPlacableTiles.length ; ++i){
				if(nonPlacableTiles[i] == tmpTile)
				return false;
			}
			return true;
		}
		
		//this function returns the distance between two movieclips
		function distance(A:MovieClip,B:MovieClip):Number{
			return Math.pow(Math.pow(B.x-A.x,2) + Math.pow(B.y-A.y,2),0.5);
		}
		
		//this function will move a monster in the game (using a loop we can move all monsters)
		function moveMonster(tmpMonster,i:int):void {
			
			//distance between the monster
			var dist_x:Number = waypoints_x[tmpMonster.nextWayPoint] - tmpMonster.x; 
			
			//and the nextWayPoint
			var dist_y:Number = waypoints_y[tmpMonster.nextWayPoint] - tmpMonster.y; 
			
			//increase the nextWayPoint if monster 
			if(Math.abs(dist_y) + Math.abs(dist_x) < 1){
				
				//collided with a waypoint
				++tmpMonster.nextWayPoint;                 
			}
			var angle:Number = Math.atan2(dist_y,dist_x); //compute the angle of the monster
			tmpMonster.x += monster_speed*Math.cos(angle);//update the x position
			tmpMonster.y += monster_speed*Math.sin(angle);//update the y position
			tmpMonster.rotation = angle/Math.PI*180;      //rotate the monster
			if(tmpMonster.x >= 475){                      //remove the monster if it touches the last wayPoint
				removeChild(tmpMonster);
				monsters.splice(i,1);
				lives -= 1;
			}
			else if(currLevel == 2 && tmpMonster.y >= 375){
				removeChild(tmpMonster);
				monsters.splice(i,1);
				lives -= 1;
			}
			if(tmpMonster.hp <= 0){                       //remove the monster if its hp becomes 0
				currGold += tmpMonster.gold;	        
			    removeChild(tmpMonster);
			    monsters.splice(i,1)
	        }
		}
		
		//this function will update a tower(using a loop we can update all towers)
		function updateTowers(tmpTower):void {
			
			//loop through all the monster
			for(var i:int = 0; i < monsters.length ; ++i){    
			
				//check if monster is in the range of the tower
				if(distance(tmpTower,monsters[i]) < tmpTower.range){      
				
					//compute angle of the bullet
					var angle:Number = Math.atan2(monsters[i].y - tmpTower.y, monsters[i].x - tmpTower.x); 
					
					//point the turret towards the nearest enemy
					tmpTower.Turret.rotation = (angle/Math.PI*180)+270;
					break;
				}
			}	
			
			 if(tmpTower.reloadTime == 0){    
			 
			 		//loop through all the monster
					for(var i:int = 0; i < monsters.length ; ++i){  
				
					//check if monster is in the range of the tower
					if(distance(tmpTower,monsters[i]) < tmpTower.range){   
				
					//compute angle of the bullet
					var angle:Number = Math.atan2(monsters[i].y - tmpTower.y, monsters[i].x - tmpTower.x);
					
					//create a Plume of smoke
					var tmpSmoke:Smoke = new Smoke(angle);
					
					if(currLevel == 0 || currLevel == 1){
						tmpSmoke.gotoAndStop(1);
					}
					else{
						tmpSmoke.gotoAndStop(2);
					}
					
					//set bullet X position to the end of the tanks barrel
			        tmpSmoke.x = tmpTower.x + Math.cos(angle) * tmpTower.bLength;   
					
					//set bullet Y position to the end of the tanks barrel
			        tmpSmoke.y = tmpTower.y + Math.sin(angle) * tmpTower.bLength; 
					
					//stageObjects.push(tmpSmoke);
			        addChild(tmpSmoke);
					
					//add tmpMuzzleFlash to the list of particles on stage
					particles.push(tmpSmoke);
					
					//create a MuzzleFlash
					var tmpMuzzleFlash:MuzzleFlash = new MuzzleFlash(angle,tmpTower.muzzleflash);
					
					//set bullet X position to the end of the tanks barrel
			        tmpMuzzleFlash.x = tmpTower.x + Math.cos(angle) * tmpTower.bLength;   
					
					//set bullet Y position to the end of the tanks barrel
			        tmpMuzzleFlash.y = tmpTower.y + Math.sin(angle) * tmpTower.bLength;   
					
					//stageObjects.push(tmpBullet);
			        addChild(tmpMuzzleFlash);
					
					//add tmpMuzzleFlash to the list of particles on stage
					particles.push(tmpMuzzleFlash);
					
					//create a bullet
					var tmpBullet:Bullet = new Bullet(angle,monsters[i],tmpTower.damage,tmpTower.speed,tmpTower.gunsound); 
					
					//set bullet X position to the end of the tanks barrel
			        tmpBullet.x = tmpTower.x + Math.cos(angle) * tmpTower.bLength;   
					
					//set bullet Y position to the end of the tanks barrel
			        tmpBullet.y = tmpTower.y + Math.sin(angle) * tmpTower.bLength;   
					
					//stageObjects.push(tmpBullet);
			        addChild(tmpBullet);
					
					//add tmpBullet to the list of bullets fired
					bullets.push(tmpBullet);    
					
					
					tmpTower.reloadTime = tmpTower.c_reloadTime;
					break;
					}
				}
			}else{
					tmpTower.reloadTime -= 1;
		    }
		}
		
		//Main event handler for when the game starts
		function onEnterFrameHandler(event:Event){
			
			if(lives <= 0){
				clearStage();
				clearWeather();
				gotoAndStop(4);
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				endStatus.text = gStrings.loss;
				mainMenuBtn.addEventListener(MouseEvent.MOUSE_UP,mainMenuBtnUpHandler);
				return 0;
			}
			
			if(monsters.length <= 0){
				if(active == true){
					wave += 1;
				}
				active = false;
				nextwaveBtn.visible = true;
			}
			
			if(wave >= 11){
				clearStage();
				clearWeather();
				gotoAndStop(4);
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				endStatus.text = gStrings.win;
				mainMenuBtn.addEventListener(MouseEvent.MOUSE_UP,mainMenuBtnUpHandler);
				return 0;
			}
			
			//update all monsters
			for(var i:int =0;i< monsters.length;++i){ 
				moveMonster(monsters[i],i);
			}
			
			//update all towers
			for(var i:int=0;i<towers.length;++i){     
				updateTowers(towers[i]);
			}
			
			//update all bullets
			for(var i:int=0;i<bullets.length;++i){    
				if(!bullets[i].remove){
					bullets[i].update();
				}else{
					removeChild(bullets[i]);
					bullets.splice(i,1);
				}
			}
			
			//update all Particles
			for(var i:int=0;i<particles.length;++i){    
				if(!particles[i].remove){
					particles[i].update();
				}else{
					removeChild(particles[i]);
					particles.splice(i,1);
				}
			}
			
			// set position of the tower to that of mouse
			if(currTower != null){                             
				currTower.x = mouseX + 1 + currTower.width/2;
				currTower.y = mouseY + 1 + currTower.height/2;
			}
			
			//display gold amount
			txtGold.text = String("Gold: " + currGold);
			
			//display wave number
			txtWave.text = String("Wave: " + wave);
			
			//display life number
			txtLives.text = String("Lives: " + lives);
		}
		
		//this function will create the Tower movieClip if user clicked on Tower Button
		function TowerBtnUpHandler(event:MouseEvent){ 
			if(currTower == null){
				currTower = new Tower();
			    addChild(currTower);
				//stageObjects.push(currTower);
			}
		}
		
		//this function will create the Tower2 movieClip if user clicked on Tower Button
		function TowerBtn2UpHandler(event:MouseEvent){ 
			if(currTower == null){
				currTower = new Tower2();
			    addChild(currTower);
				//stageObjects.push(currTower);
			}
		}
		
		//this function will create the Tower3 movieClip if user clicked on Tower Button
		function TowerBtn3UpHandler(event:MouseEvent){ 
			if(currTower == null){
				currTower = new Tower3();
			    addChild(currTower);
				//stageObjects.push(currTower);
			}
		}
		
		//this function will place the tower when user clicks on the stage
		function onMouseDownHandler(event:MouseEvent){
			if(currTower != null){
				if(checkPlacable(currTile)){                           //check if placable
				if((currGold-currTower.cost)>=0){                      //check if there is enough gold to place the 
				if(mouseX < 500){                                      //tower
					txtStatus.text = "";
					currGold -= currTower.cost;
					towers.push(currTower);
					currTower.x = currTile.x + currTile.width/2;        //place the tower on the tile
				    currTower.y = currTile.y + currTile.height/2;
				    currTower = null;
					nonPlacableTiles.push(currTile);                    //add the current Tile into nonPlacableTiles
				}                                                       //after placing the tower
				}else{
					txtStatus.text = "not enough gold";
				}                                                           
			    }
				if(mouseX >500 && mouseX<600){
				   removeChild(currTower);
				   currTower = null;
			    }
			}
		}
	}
}