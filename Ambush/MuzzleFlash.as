package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	//used for requesting resources
	import flash.net.URLRequest; 
	
	//used for timers
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	
	public class MuzzleFlash extends MovieClip {
		
		//Particle remove boolean
		var remove:Boolean;
		
		public function MuzzleFlash(rotate:Number,muzzleFlash:int){
			this.rotation = rotate/Math.PI*180;
			this.gotoAndStop(muzzleFlash);
		}
		
		public function update() {
			if(this.alpha <= 0){
				remove = true;
			}
			this.alpha -= 0.1;
		}
	}
}