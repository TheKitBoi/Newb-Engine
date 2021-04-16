package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

// my code is shit so beware lol

class OptionsState extends MusicBeatState
{
	var textMenuItems:Array<String> = ['Multipliers', 'Gamechangers'];
	var multiplierItems:Array<String> = ['Health Multiplier', 'Score Multiplier'];
	var gameChangers:Array<String> = ['Full Energy', 'Antispam', 'Bot Mode'];
	var optionMenus:Array<Array> = [textMenuItems, multiplierItems, gameChangers];
	var menuItems:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;
	var curMenu:Int = 0;

	// startup values might make a saving system later????? 
	public static var healthMultiplier:Int = 1;
	public static var scoreMultiplier:Int = 1;
	public static var fullEnergy:Bool = true;
	public static var antiSpam:Bool = false;
	public static var botMode:Bool = false;

	private var optionText:FlxText;

    override public function create():Void
    {
		var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuBGBlue.png');
		add(bg);
		optionText = new FlxText(1130, 10, 128, "", 100);
		optionText.setFormat("assets/fonts/vcr.ttf", 64, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
		add(optionText);

		menuItems = new FlxTypedGroup<Alphabet>();
		add(menuItems);

		for (i in 0...textMenuItems.length)
		{
			var menuText:Alphabet = new Alphabet(0, (70 * i) + 30, textMenuItems[i], true, false);
			menuText.isMenuItem = true;
			menuText.targetY = i;
			menuItems.add(menuText);
		}
        super.create();
    }

    override function update(elapsed:Float)
		{
			switch(curSelected){
				case 0:
					optionText.text = healthMultiplier + "x";
				case 1:
					optionText.text = scoreMultiplier + "x";
				case 2:
					optionText.text = boolToOnOff(fullEnergy);
				case 3:
					optionText.text = boolToOnOff(antiSpam);
				case 4:
					optionText.text = boolToOnOff(botMode);
			}
			var upP = controls.UP_P;
			var downP = controls.DOWN_P;
			var accepted = controls.ACCEPT;
			var back = controls.BACK;

			if (upP)
			{
				changeSelection(-1);
			}
			if (downP)
			{
				changeSelection(1);
			}
			// this code can probably be improved but i suck at coding so whatevz
			if (controls.LEFT_P)
			{
				switch(curSelected){
					case 0:
						if (healthMultiplier >= 2)
							healthMultiplier -= 1;
					case 1:
						if (scoreMultiplier >= 2)
							scoreMultiplier -= 1;
					case 2:
						fullEnergy = false;
					case 3:
						antiSpam = false;
					case 4:
						botMode = false;
				}
			}
			if (controls.RIGHT_P)
			{
				switch(curSelected){
					case 0:
						if (healthMultiplier <= 4)
							healthMultiplier += 1;
					case 1:
						if (scoreMultiplier <= 4)
							scoreMultiplier += 1;
					case 2:
						fullEnergy = true;
					case 3:
						antiSpam = true;
					case 4:
						botMode= true;
				}
			}

			if (back)
			{
				FlxG.switchState(new MainMenuState());
			}	
			super.update(elapsed);
		}	
	function changeSelection(change:Int = 0)
	{
		// NGio.logEvent('Fresh');
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;
		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in menuItems.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
	function boolToOnOff(variable:Bool = true)
	{
		// funny bool to on-off function bc its used ez
		if (variable)
			return "ON";
		else
			return "OFF";
	}
	function refreshState()
}