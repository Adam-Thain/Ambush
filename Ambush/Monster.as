package {
	import flash.display.MovieClip;

	public class Monster extends MovieClip{

		//next point from which the monster should turn
		var nextWayPoint:int = 0;

		//HP of the monster
		var hp:int = 80;

		//reward for killing the monster
		var gold:int = 150;
		
		public function Monster(){

		}
	}
}