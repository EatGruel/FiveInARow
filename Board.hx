package;

import flixel.FlxSprite;

class Board extends FlxSprite
{     
    public var full:Bool = false;
	public function new(x:Float = 0, y:Float = 0)
	{
		
		super(x, y);
        loadGraphic(AssetPaths.goboard__png, false, 7, 7);
        
	}
}