package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;

class PlayState extends FlxState
{
	var array:Array<Array<Int>> = [for (x in 0...18) [for (y in 0...18) 0]];
	var whitepieces:FlxTypedGroup<Piece>;
	var blackpieces:FlxTypedGroup<Piece>;
	var boards:FlxTypedGroup<Board>;
	var board:Board;
	var piece:Piece;
	var x:Int;
	var y:Int;

	var count:Int;

	public var whitewin = false;

	function getScore(xpos:Int, ypos:Int, playercolor:Int):Float
	{
		var scoresum:Float = 0;
		var blocked:Bool = false;

		for (i in -1...2)
		{
			for (j in -1...2)
			{
				if (!(i == 0 && j == 0))
				{
					for (k in 0...5)
					{
						blocked = false;
						count = 0;
						for (f in -4...1)
						{
							if (xpos + (k + f) * i < 18 && xpos + (k + f) * i >= 0 && ypos + (k + f) * j < 18 && ypos + (k + f) * j >= 0)
							{
								if (array[xpos + (k + f) * i][ypos + (k + f) * j] == playercolor)
								{
									count += 1;
								}
								else if (array[xpos + (k + f) * i][ypos + (k + f) * j] > 0)
								{
									blocked = true;
								}
							}
						}
						if (blocked)
						{
							scoresum += 0;
						}
						else
						{
							scoresum += Math.pow(100.0,count-2);
						}
					}
				}
			}
		}

		return scoresum;
	}

	function placePiece(board:Board)
	{
		var bestxy:Array<Int> = [10, 10];
		var highscore:Float = -10000;

		if (!board.full)
		{
			piece = new Piece(board.x + 1, board.y + 1, true);
			whitepieces.add(piece);
			add(piece);

			array[Std.int(board.x / 7)][Std.int(board.y / 7)] = 1;
			x = Std.int(board.x / 7);
			y = Std.int(board.y / 7);

			if (getScore(x, y, 1) > 1000000)
			{
				FlxG.switchState(new MenuState(true, true));
			}

			for (i in 0...18)
			{
				for (j in 0...18)
				{
					if (array[i][j] == 0)
					{
						if (3*getScore(i, j, 2) + getScore(i, j, 1) > highscore)
						{
							bestxy = [i, j];
							highscore = 3*getScore(i, j, 2) + getScore(i, j, 1);
						}
					}
				}
			}

			board.full = true;

			for (b in boards)
			{
				if (bestxy[0] == Std.int(b.x / 7) && bestxy[1] == Std.int(b.y / 7))
				{
					piece = new Piece(b.x + 1, b.y + 1, false);
					blackpieces.add(piece);
					b.full = true;
					add(piece);

					array[bestxy[0]][bestxy[1]] = 2;
					trace(array);

					if (getScore(bestxy[0], bestxy[1], 2) > 1000000)
					{
						FlxG.switchState(new MenuState(false, true));
					}
				}
			}
		}
	}

	override public function create()
	{
		super.create();

		FlxG.plugins.add(new FlxMouseEventManager());

		whitepieces = new FlxTypedGroup<Piece>();
		blackpieces = new FlxTypedGroup<Piece>();
		boards = new FlxTypedGroup<Board>();

		for (i in 0...18)
		{
			for (j in 0...18)
			{
				board = new Board(7 * i, 7 * j);
				add(board);
				boards.add(board);
				FlxMouseEventManager.add(board, placePiece);
			}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
