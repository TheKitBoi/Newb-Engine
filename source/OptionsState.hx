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

class OptionsState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Health Multiplier', 'Score Multiplier'];
	var menuItems:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;

	public static var healthMultiplier:Int = 1;
	public static var scoreMultiplier:Int = 1;

	var multiplierText = new FlxText(0, 0, 2, "", 40);

    override public function create():Void
    {
		var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuBGBlue.png');
		add(bg);
		multiplierText.setFormat("assets/fonts/vcr.ttf", 32, FlxColor.WHITE, RIGHT);
		multiplierText.scrollFactor.set();

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
			// Ugh - Friday Night Funkin OST
			if (controls.LEFT_P)
				if (curSelected == 0)
					healthMultiplier -= 1;
				else
					scoreMultiplier -= 1;
			if (controls.RIGHT_P)
				if (curSelected == 0)
					healthMultiplier += 1;
				else
					scoreMultiplier += 1;

			if (back)
			{
				FlxG.switchState(new MainMenuState());
			}	

			if (accepted)
			{
				// we dont NEED to press enter :eyes:
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
}