package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import js.html.AlignSetting;

class MenuState extends FlxState
{
	var startedgame:Bool;
	var playButton:FlxButton;
	var text:FlxText;
	var whitewin:Bool;
    var notfirst:Bool;

	function clickPlay()
	{
		startedgame = true;
		FlxG.switchState(new PlayState());
	}

	public function new(whitewin:Bool = false, notfirst:Bool = false)
	{
		super();
		this.whitewin = whitewin;
        this.notfirst = notfirst;
	}

	override public function create():Void
	{
		if (notfirst)
		{
			if (whitewin)
			{
				text = new FlxText(10, 10, 100, "White Winner!");
			}
			else
			{
				text = new FlxText(10, 10, 100, "Black Winner!");
			}
			add(text);
		}
		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.screenCenter();
		add(playButton);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
