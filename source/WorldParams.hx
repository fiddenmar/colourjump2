/*	Colourjump2 - WorldParams.hx
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

class WorldParams
{
	public var fallSpeed : Int;

	public var boardSpawnRight : Int;
	public var boardSpawnTime : Float;
	public var boardSpeedX : Int;
	public var boardSpeedY : Int;

	public var gravity : Int;

	public function new(?_fallSpeed:Int = 1000, ?_boardSpawnRight:Int = 1, ?_boardSpawnTime:Float = 0.4, ?_boardSpeedX:Int = 600, ?_boardSpeedY:Int = 0, ?_gravity:Int = 980)
	{
		fallSpeed = _fallSpeed;
		boardSpawnRight = _boardSpawnRight;
		boardSpawnTime = _boardSpawnTime;
		boardSpeedX = _boardSpeedX;
		boardSpeedY = _boardSpeedY;
		gravity = _gravity;
	}

	public function new2(wp:WorldParams)
	{
		fallSpeed = wp.fallSpeed;
		boardSpawnRight = wp.boardSpawnRight;
		boardSpawnTime = wp.boardSpawnTime;
		boardSpeedX = wp.boardSpeedX;
		boardSpeedY = wp.boardSpeedY;
		gravity = wp.gravity;
	}
}