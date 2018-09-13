package 
{
	import flash.events.Event;
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 

	public class Waves 
	{	
	
		//distance between monsters
		var distance:int;
		
		public function waves(wave:int)
		{	
			if (wave == 1)
			{			
			
				Main.instance.monsterno = 10;
			
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					distance = 55;
					
					//function for creating monsters
					Main.instance.createMonster2(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
				}
			}

			if (wave == 2)
			{
				
				Main.instance.monsterno = 15;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					distance = 55;
					
					//function for creating monsters
					Main.instance.createMonster2(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
				}
			}
			
			if (wave == 3)
			{
				
				Main.instance.monsterno = 15;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					if (i < 5)
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster2(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
					}
					else
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster3(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
					}
				}
			}
			
			if (wave == 4)
			{
				Main.instance.monsterno = 15;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					distance = 55;
					
					//function for creating monsters
					Main.instance.createMonster3(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
				}
			}
			
			if (wave == 5)
			{
				Main.instance.monsterno = 20;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					if (i < 10)
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster3(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
					}
					else
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster4(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
						
					}
				}
			}
			
			if (wave == 6)
			{
				
				Main.instance.monsterno = 20;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					if (i < 10)
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster4(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
					}
					else
					{
						distance = 70;
						
						//function for creating monsters
						Main.instance.createMonster(Main.instance.monster_startx -i*distance + 150,Main.instance.waypoints_y[0]);
					}
				}
			}
			
			if (wave == 7)
			{
				
				Main.instance.monsterno = 20;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					
					if (i < 10)
					{
						distance = 70;
						
						//function for creating monsters
						Main.instance.createMonster(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
					}
					else
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster2(Main.instance.monster_startx -i*distance - 150,Main.instance.waypoints_y[0]);
					}
				}
			}

			if (wave == 8)
			{
				
				Main.instance.monsterno = 20;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					
					if (i < 5)
					{
						distance = 70;
						
						//function for creating monsters
						Main.instance.createMonster(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
					}
					else
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster2(Main.instance.monster_startx -i*distance - 80,Main.instance.waypoints_y[0]);;
					}
				}
			}
			
			if (wave == 9)
			{
				
				Main.instance.monsterno = 20;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					distance = 70;
					
					//function for creating monsters
					Main.instance.createMonster(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
				}
			}
			
			if (wave == 10)
			{
				Main.instance.monsterno = 30;
				
				for (var i:int=0; i<Main.instance.monsterno; ++i)
				{
					if (i < 5)
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster2(Main.instance.monster_startx -i*distance,Main.instance.waypoints_y[0]);
					}
					else if(i > 5 && i<= 11)
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster3(Main.instance.monster_startx -i*distance + 55,Main.instance.waypoints_y[0]);
					}
					else if(i > 10 && i<= 16)
					{
						distance = 55;
						
						//function for creating monsters
						Main.instance.createMonster4(Main.instance.monster_startx -i*distance + 110,Main.instance.waypoints_y[0]);
					}
					else if(i > 15 && i<= 21)
					{
						distance = 70;
						
						//function for creating monsters
						Main.instance.createMonster(Main.instance.monster_startx -i*distance + 360,Main.instance.waypoints_y[0]);
					}
					else if(i > 20 && i<= 26)
					{
						distance = 70;
						
						//function for creating monsters
						Main.instance.createMonster5(Main.instance.monster_startx -i*distance + 355,Main.instance.waypoints_y[0]);
					}
				}
			}
		}
	}
}