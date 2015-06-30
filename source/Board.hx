/*	Colourjump2 - Board.hx
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

class Board extends FlxSprite
{
	private var sprite : FlxSprite;
	private var spriteNumber : Int;
	private var speedX : Int;
    private var speedY : Int;

	public function new()
    {
        super();

        exists = false;
    }

    public function appear(X:Int, Y:Int, wp:WorldParams, cn:Int)
    {
        Reg.boardCreating = true;
        
        super.reset(X, Y);

        spriteNumber = cn;
        loadGraphicFromSprite(Reg.boardImages[spriteNumber]);
        //maxVelocity.set(wp.boardSpeedX, wp.boardSpeedY);
        velocity.x = -wp.boardSpeedX;
        velocity.y = -wp.boardSpeedY;
        setSize(192, 64);
        offset.set(5, 8);
        Reg.boardCreating = false;
    }

    public override function update():Void
    {
        if (!alive)
        {
            exists = false;
        }

        if (x + width < 0 || x - 2*width > FlxG.width)
            kill();
        
        super.update();
    }

    public function getSpriteNumber():Int
    {
        return spriteNumber;
    }
}