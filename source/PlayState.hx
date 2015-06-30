/*	Colourjump2 - PlayState.hx
    Copyright (C) 2015  Evgeny Petrov, fiddenmar@gmail.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;


class PlayState extends FlxState
{
	private var background : FlxSprite;
	private var backgroundNumber : Int;

	private var score: FlxText;

	private var spawnTimer : FlxTimer;

	private var worldParams : WorldParams;

	private var player : Player;
	private var boards : FlxTypedGroup<Board>;

	private function loadBackgroundImages()
	{
		Reg.backgroundImages = new Array<FlxSprite>();
		var i = 0;
		while (i<8)
		{
			var image = new FlxSprite();
			image.loadGraphic('assets/images/bg'+i+'.png');
			image.setGraphicSize(FlxG.width, FlxG.height);
			image.x = (FlxG.width-image.width) / 2;
			image.y = (FlxG.height-image.height) / 2;
			Reg.backgroundImages.push(image);
			i++;
		}
	}

	private function loadPlayerImages()
	{
		Reg.playerImages = new Array<FlxSprite>();
		var i = 0;
		while (i<8)
		{
			var image = new FlxSprite();
			image.loadGraphic('assets/images/player'+i+'.png');
			Reg.playerImages.push(image);
			i++;
		}
	}

	private function loadBoardImages()
	{
		Reg.boardImages = new Array<FlxSprite>();
		var i = 0;
		while (i<8)
		{
			var image = new FlxSprite();
			image.loadGraphic('assets/images/board'+i+'.png');
			Reg.boardImages.push(image);
			i++;
		}
	}

	private function loadImages()
	{
		loadBackgroundImages();
		loadPlayerImages();
		loadBoardImages();
	}

	private function createScore()
	{
		var scoreString = "Score: " + 0;
		score = new FlxText(scoreString);
		score.x = 24;
		score.y = 24;
		score.bold = true;
		score.setFormat("assets/fonts/FreeMono.ttf", 36, FlxColor.BLACK);
	}

	private function addBoard(Timer:FlxTimer):Void
	{
		var x = Std.int(FlxG.width * (worldParams.boardSpawnRight) + Reg.boardImages[0].width * (worldParams.boardSpawnRight-1));
		var y = FlxRandom.intRanged(Std.int(FlxG.height*0.4), Std.int(FlxG.height*0.9));
		var num = FlxRandom.intRanged(0, Reg.boardImages.length-1, [backgroundNumber]);
		var board = boards.recycle(Board);
		if (board != null)
			board.appear(x, y, worldParams, num);
	}

	private function collisionPlayerBoard(p:FlxObject, b:FlxObject)
	{
		var pl = cast(p, Player);
		var bd = cast(b, Board);
		if (pl.getContact() == bd)
		{
			pl.jump();
			return;
		}

		pl.setContact(bd);
		var plSpriteNumber = pl.getSpriteNumber();
		if (pl.velocity.y >= 0)
		{
			if (pl.getSpriteNumber() != bd.getSpriteNumber())
			{
				worldParams = pl.changeColour(bd.getSpriteNumber());
			}
			if (plSpriteNumber == 3)
			{
				bd.kill();
				updateScore(5);
			}
			else if (plSpriteNumber == 6)
			{
				bd.velocity.y = 1500;
				updateScore(5);
			}
			else
				updateScore(1);
			pl.jump();
			
		}
		else
		{
			if (plSpriteNumber == 5)
			{
				bd.kill();
			}
			else
			{
				pl.velocity.y = 0;
				backgroundNumber = bd.getSpriteNumber();
				background.loadGraphicFromSprite(Reg.backgroundImages[backgroundNumber]);
				bd.kill();
			}	
			updateScore(10);
		}
	}

	function updateScore(i:Int)
	{
		player.updateScore(i);
		drawScore();
	}

	function drawScore()
	{
        var scoreString = "Score: " + player.getScore();
        remove(score);
		score = new FlxText(scoreString);
		score.x = 24;
		score.y = 24;
		score.bold = true;
		score.setFormat("assets/fonts/FreeMono.ttf", 36, FlxColor.BLACK);
		add(score);
	}

	override public function create():Void
	{
		Reg.gameOver = false;

		if (Reg.imagesLoaded == false)
			loadImages();
		Reg.imagesLoaded = true;

		backgroundNumber = 0;
		background = new FlxSprite();
		background.loadGraphicFromSprite(Reg.backgroundImages[backgroundNumber]);
		background.setGraphicSize(FlxG.width, FlxG.height);
		background.x = (FlxG.width-background.width) / 2;
		background.y = (FlxG.height-background.height) / 2;

		worldParams = new WorldParams();

		player = new Player(400, 64, worldParams);	
		createScore();

		boards = new FlxTypedGroup<Board>();
		boards.maxSize = 50;
		for (i in 0...50)
		{
			boards.add(new Board());
		}

		add(background);
		add(player);
		add(score);
		add(boards);

		spawnTimer = new FlxTimer(worldParams.boardSpawnTime, addBoard, 0);

		super.create();
	}
	
	override public function destroy():Void
	{
		remove(background);
		remove(player);
		remove(score);
		remove(boards);
		background = null;
		player = null;
		boards = null;
		Reg.imagesLoaded = false;
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		FlxG.overlap(player, boards, collisionPlayerBoard);
		if (Reg.gameOver)
		{
			Reg.score = player.getScore();
			FlxG.switchState(new MenuState());
		}
	}	
}