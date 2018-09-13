package{
	
	//used for sounds
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	//used for requesting resources
	import flash.net.URLRequest; 
	import fl.events.SliderEvent;
	
	
	public class SoundManager{
		
		var BGVolume = 10;
		var SFXVolume = 10;
		
		//soundchannel for background music
		var backgroundMusic:FiveArmies = new FiveArmies();
		
		//get Light Gun sound
		var LightGunSound:LightGun = new LightGun();
		
		//get Medium Gun sound
		var MediumGunSound:MediumGun = new MediumGun();
		
		//get Heavy Gun sound
		var HeavyGunSound:HeavyGun = new HeavyGun();
		
		var BGMTransform:SoundTransform = new SoundTransform();
		var LGTransform:SoundTransform = new SoundTransform();
		var MGTransform:SoundTransform = new SoundTransform();
		var HGTransform:SoundTransform = new SoundTransform();
		
		var BGMChannel:SoundChannel = new SoundChannel();
		var LGChannel:SoundChannel = new SoundChannel();
		var MGChannel:SoundChannel = new SoundChannel();
		var HGChannel:SoundChannel = new SoundChannel();
		
		//play Background sound
		function playBackgroundMusic():void{
			BGMChannel = backgroundMusic.play(1,999,BGMTransform);
		}	
		
		//play Medium Gun sound
		function playLightGunSound():void{
			LGChannel = LightGunSound.play(0,0,LGTransform);
		}	
		
		//play Medium Gun sound
		function playMediumGunSound():void{
			MGChannel = MediumGunSound.play(0,0,MGTransform);
		}	
		
		//play Heavy Gun sound
		function playHeavyGunSound():void{
			HGChannel = HeavyGunSound.play(0,0,HGTransform);
		}	
		
		function ChangeBGMusicVolume(event:SliderEvent):void{
			
			BGVolume = event.target.value * 10;
			BGMTransform.volume = event.target.value;
			BGMChannel.soundTransform = BGMTransform;
			Main.instance.musicSliderNumber.text = String(event.target.value * 10);
		}
		
		function ChangeSFXMusicVolume(event:SliderEvent):void{
			
			SFXVolume = event.target.value * 10;
			LGTransform.volume = event.target.value;
			MGTransform.volume = event.target.value;
			HGTransform.volume = event.target.value;
			LGChannel.soundTransform = LGTransform;
			MGChannel.soundTransform = MGTransform;
			HGChannel.soundTransform = HGTransform;
			Main.instance.SFXSliderNumber.text = String(event.target.value * 10);
		}
	}
}