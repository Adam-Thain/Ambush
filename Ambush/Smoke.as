package{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	//used for requesting resources
	import flash.net.URLRequest; 
	
	//used for timers
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	
	public class Smoke extends MovieClip {
		
		//Particle remove boolean
		var remove:Boolean;
		
		public function Smoke(rotate:Number){
			this.rotation = rotate/Math.PI*180;
		}
		
		public function update() {
			if(this.alpha <= 0){
				remove = true;
			}
			this.alpha -= 0.02;
		}
	}
}