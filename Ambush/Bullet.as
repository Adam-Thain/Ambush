package {
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.geom.Point;
	
	public class Bullet extends MovieClip{
		
		//bullet speed
		var speed:Number;
		
		//bullet target
		var Target;
		
		//bullet angle
		var angle:Number;
		
		//bullet remove boolean
		var remove:Boolean;
		
		//bullet damage
		var damage:Number;
		
		//link to sound manager
		var gSoundManager = new SoundManager();
		
		public function Bullet(rotate:Number,tmpMonster,bulletDamage:Number,bulletSpeed:Number,gunsound:int){
			angle = rotate;
			Target = tmpMonster;
			speed = bulletSpeed;
			damage = bulletDamage;
			/*if(gunsound == 1){
				gSoundManager.playLightGunSound();
			}*/
			if(gunsound == 1){
				gSoundManager.playLightGunSound();
			}
			else if(gunsound == 2){
				gSoundManager.playMediumGunSound();
			}
			else if(gunsound == 3){
				gSoundManager.playHeavyGunSound();
			}
			this.rotation = angle/Math.PI*180;
		}
		
		public function update() {
			
			this.x += speed*Math.cos(angle);
			this.y += speed*Math.sin(angle);
			
			if(this.hitTestObject(Target)){
				Target.hp -= damage;
				remove = true;
			}
		}
	}
}