/*	Colourjump2 - Player.hx
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

class Player extends FlxSprite
{
	private var score:Int;
	private var gravity:Int;
	private var fallSpeed:Int;
	private var spriteNumber:Int;
	private var gameStarted:Int;
	private var contact:Board;

	public function new(X:Int, Y:Int, wp:WorldParams)
	{
		score = 0;
		gravity = wp.gravity;
		fallSpeed = wp.fallSpeed;

		super(X, Y);

		spriteNumber = 0;
		loadGraphicFromSprite(Reg.playerImages[spriteNumber]);

		gameStarted = 0;

		maxVelocity.set(0, fallSpeed);

		setSize(64, 64);
		offset.set(5, 8);
		contact = null;
	}

	public override function update():Void
	{
		velocity.x = 0;
		#if desktop
			if (FlxG.keys.anyPressed(["SPACE", "X", "DOWN"]))
			{
				if (gameStarted == 0)
					acceleration.y = gravity;
				fall();
			}
		#elseif mobile
			for (touch in FlxG.touches.list)
			{
			    if (touch.justPressed)
			    {
			    	if (gameStarted == 0)
					acceleration.y = gravity;
					fall();
			    }
			}
		#end
		if (x < 0 || x + width > FlxG.width || y < 0 || y + height > FlxG.height)
		{
			Reg.gameOver = true;
		}
		super.update();
	}

	public function changeColour(n:Int):WorldParams
	{
		spriteNumber = n;
		loadGraphicFromSprite(Reg.playerImages[spriteNumber]);
		return updateCondition();
	}

	private function updateCondition():WorldParams
	{
		var worldParams = new WorldParams();
		switch (spriteNumber)
		{
			case 0:
			{
				//default
			}
			case 1:
			{
				worldParams.boardSpeedY = 100;
			}
			case 2:
			{
				worldParams.boardSpawnRight = 0;
				worldParams.boardSpeedX *= -1;
			}
			case 3:
			{
				worldParams.boardSpawnRight = 0;
				worldParams.boardSpeedX *= -1;
				worldParams.boardSpeedY = - 30;
			}
			case 4:
			{
				worldParams.boardSpeedY = - 30;
			}
			case 5:
			{
				//done
			}
			case 6:
			{
				//done
			}
			case 7:
			{
				worldParams.boardSpawnRight = 0;
				worldParams.boardSpeedX *= -1;
				worldParams.boardSpeedY = - 30;
				
			}
		}
		return worldParams;
	}

	public function jump():Void
	{
		var h = y - height;
		var vel = (h + gravity/2)*0.9;
		velocity.y = -Std.int(vel);
	}

	public function fall():Void
	{
		velocity.y = fallSpeed;
	}

	public function getSpriteNumber():Int
    {
        return spriteNumber;
    }

    public function updateScore(i:Int)
    {
    	score += i;
    }

    public function getScore():Int
    {
    	return score;
    }

    public function setContact(b:Board)
    {
    	contact = b;
    }

    public function getContact():Board
    {
    	return contact;
    }
}
