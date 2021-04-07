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
	var textMenuItems:Array<String> = ['Health Multiplier', 'Score Multiplier', 'Full Energy'];
	var menuItems:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;

	public static var healthMultiplier:Int = 1;
	public static var scoreMultiplier:Int = 1;
	public static var fullEnergy:Bool = true;

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
			// this entire thing can also be improved
			if (curSelected == 0){
				optionText.text = healthMultiplier + "x";
			}
			else if (curSelected == 1){
				optionText.text = scoreMultiplier + "x";
			}
			else
				optionText.text = boolToOnOff(fullEnergy);
			// end of shit code
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
				if (curSelected == 0 && healthMultiplier >= 2)
					healthMultiplier -= 1;
				if (curSelected == 1 && scoreMultiplier >= 2)
					scoreMultiplier -= 1;
				if (curSelected == 2)
					fullEnergy = false;
			}
			if (controls.RIGHT_P)
			{
				if (curSelected == 0 && healthMultiplier <= 4)
					healthMultiplier += 1;
				if (curSelected == 1 && scoreMultiplier <= 4)
					scoreMultiplier += 1;
				if (curSelected == 2)
					fullEnergy = true;
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
		if (variable)
			return "ON";
		else
			return "OFF";
	}
}