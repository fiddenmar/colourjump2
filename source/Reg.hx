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


import flixel.FlxSprite;
import flixel.system.FlxSound;

class Reg
{
	public static var score:Int = -1;
    public static var imagesLoaded:Bool = false;
    public static var backgroundImages : Array<FlxSprite> = null;
    public static var playerImages : Array<FlxSprite> = null;
    public static var boardImages : Array<FlxSprite> = null;
    public static var gameOver: Bool = false;
    public static var boardCreating:Bool = false;
    public static var musicOn:Bool = false;
    public static var musicLoaded:Bool = false;
    public static var soundExtension:String = ".ogg";
}