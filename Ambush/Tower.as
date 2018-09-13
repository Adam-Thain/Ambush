package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Tower extends MovieClip{
		
		const c_reloadTime = 30;
		
		var reloadTime:int;
		var range:int;
		var cost:int;
		var damage:int;
		var gunsound:int = 1;
		var muzzleflash:int = 1;
		var speed:int;
		var bLength:int;
		
		public function Tower()
		{
			reloadTime = 30;
			range = 150;
			cost = 200;
			damage = 5;
			gunsound = 1;
			muzzleflash = 1;
			speed = 6;
			bLength = 18;
		}
	}
}