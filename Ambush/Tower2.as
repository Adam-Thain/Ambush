package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Tower2 extends MovieClip{
		
		const c_reloadTime = 36;
		
		var reloadTime:int;
		var range:int;
		var cost:int;
		var damage:int;
		var gunsound:int;
		var muzzleflash:int;
		var speed:int;
		var bLength:int;
		
		public function Tower2()
		{
			reloadTime = 50;
			range = 200;
			cost = 400;
			damage = 6;
			gunsound = 2;
			muzzleflash = 2;
			speed = 8;
			bLength = 22;
		}
	}
}