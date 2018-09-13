package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Tower3 extends MovieClip{
		
		const c_reloadTime = 65;
		
		var reloadTime:int;
		var range:int;
		var cost:int;
		var damage:int;
		var gunsound:int;
		var muzzleflash:int;
		var speed:int;
		var bLength:int;
		
		public function Tower3()
		{
			reloadTime = 80;
			range = 100;
			cost = 600;
			damage = 30;
			gunsound = 3;
			muzzleflash = 3;
			speed = 5;
			bLength = 24;
		}
	}
}