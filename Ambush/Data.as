package{
	public class Data{
		
		//level waypoints
		public var levels:Array = new Array();
		public var waypoints_x:Array = new Array();
		public var waypoints_y:Array = new Array();
		
		//level 1 waypoints
		public var level1:Array = new Array();
		public var waypoints_x_1:Array = new Array();
		public var waypoints_y_1:Array = new Array();
		
		//level 2 waypoints
		public var level2:Array = new Array();
		public var waypoints_x_2:Array = new Array();
		public var waypoints_y_2:Array = new Array();
		
		//level 3 waypoints
		public var level3:Array = new Array();
		public var waypoints_x_3:Array = new Array();
		public var waypoints_y_3:Array = new Array();
		
		//level 3 waypoints
		public var level4:Array = new Array();
		public var waypoints_x_4:Array = new Array();
		public var waypoints_y_4:Array = new Array();
		
		public function setUp(){
			
			//setup level 1
			level1 = [[0,0,0,0,1,1,1,1,1,0],
					 [0,0,0,0,1,0,0,0,1,0],
					 [1,1,0,0,1,0,0,0,1,0],
					 [0,1,0,0,1,0,0,0,1,0],
					 [0,1,0,0,1,0,0,0,1,0],
					 [0,1,1,1,1,0,0,0,1,0],
					 [0,0,0,0,0,0,0,0,1,1],
					 [0,0,0,0,0,0,0,0,0,0],
					];
					
			//setup level 2
			level2 = [[0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,1,1,1,1,1,1],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [1,1,1,1,1,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					];
					
			//setup level 3
			level3 = [[3,3,3,3,3,3,3,3,3,3],
					 [4,4,4,4,4,3,3,3,3,3],
					 [3,3,3,3,4,3,3,3,3,3],
					 [3,3,3,3,4,3,3,3,3,3],
					 [3,3,3,3,4,3,3,3,3,3],
					 [3,3,3,3,4,3,3,3,3,3],
					 [3,3,3,3,4,3,3,3,3,3],
					 [3,3,3,3,4,3,3,3,3,3],
					];	
				
			//setup level 4
			level4 = [[5,5,5,5,5,5,5,5,5,5],
					 [5,5,6,6,6,6,5,5,5,5],
					 [5,5,6,5,5,6,6,6,6,6],
					 [5,5,6,5,5,5,5,5,5,5],
					 [5,5,6,6,6,6,6,6,5,5],
					 [5,5,5,5,5,5,5,6,5,5],
					 [6,6,6,6,5,5,5,6,5,5],
					 [5,5,5,6,6,6,6,6,5,5],
					];			
					
		    //waypoints are points from which the monster must turn
			
			//waypoints for level 1
			waypoints_x_1 = [75 ,75 ,225,225,425,425,475];
			waypoints_y_1 = [125,275,275,25 ,25 ,325,325];
			
			//waypoints for level 2
			waypoints_x_2 = [225,225,475];
			waypoints_y_2 = [275,75,75];
			
			//waypoints for level 3
			waypoints_x_3 = [225,225];
			waypoints_y_3 = [75,375];
			
			//waypoints for level 4
			waypoints_x_4 = [175,175,375,375,125,125,275,275,475];
			waypoints_y_4 = [325,375,375,225,225,75,75,125,125];
			
			levels = [level1,level2,level3,level4];
			waypoints_x = [waypoints_x_1,waypoints_x_2,waypoints_x_3,waypoints_x_4];
			waypoints_y = [waypoints_y_1,waypoints_y_2,waypoints_y_3,waypoints_y_4];
		}
	}
}