package;

import flixel.FlxSprite;

class Piece extends FlxSprite
{
	public var white:Bool;
    
    public function new(x:Float = 0, y:Float = 0, white:Bool)
	{
		
        super(x, y);
		this.white = white;
        if(white){
			loadGraphic(AssetPaths.whitepiece__png, true, 5, 5);


        } else{

			loadGraphic(AssetPaths.blackpiece__png, true, 5, 5);
        }
	}
}