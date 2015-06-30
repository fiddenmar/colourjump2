/*	Colourjump2 - MenuState.hx
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
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flash.system.System;

class MenuState extends FlxState
{
	private var option: FlxText;
	private var optionsArray: Array<FlxText>;
	private var optionsStringArray: Array<String>;
	private var optionSelected:Int;
	private var numberOfOptions:Int;

	private var background: FlxSprite;

	private var score: FlxText;

	private function createBackground():Void
	{
		background = new FlxSprite();
		background.loadGraphic("assets/images/menu_background.png");
		background.setGraphicSize(FlxG.width, FlxG.height);
		//background.centerOffsets(true);
		background.x = (FlxG.width-background.width) / 2;
		background.y = (FlxG.height-background.height) / 2;

		add(background);
	}

	private function fillInOptionStrings():Void
	{
		optionsStringArray = new Array<String>();
		optionsStringArray.push("start");
		optionsStringArray.push("music on/off");
		optionsStringArray.push("source code");
		//optionsStringArray.push("exit");
		numberOfOptions = optionsStringArray.length;
	}

	private function createOptions():Void
	{
		optionsArray = new Array<FlxText>();
		for (optionString in optionsStringArray)
		{
			var text = new FlxText("-> "+optionString);
			text.x = FlxG.width / 2;
			text.y = FlxG.height / 2;
			text.bold = true;
			text.setFormat("assets/fonts/FreeMono.ttf", 36, FlxColor.WHITE, "centered");
			optionsArray.push(text);
		}
		option = optionsArray[0];
		optionSelected = 0;
		add(option);
	}

	private function updateOption():Void
	{
		remove(option);
		option = optionsArray[optionSelected];
		add(option);
	}

	private function createScore():Void
	{
		if (Reg.score != -1)
		{
			var scoreString = "Score: " + Reg.score;
			score = new FlxText(scoreString);
			score.x = 0;
			score.y = 24;
			score.bold = true;
			score.setFormat("assets/fonts/FreeMono.ttf", 24, FlxColor.WHITE);
			add(score);
		}
	}

	override public function create():Void
	{
		#if desktop
			FlxG.mouse.visible = false;
		#end
		createBackground();
		fillInOptionStrings();
		createOptions();
		createScore();
		super.create();
	}
	
	override public function destroy():Void
	{
		remove(optionsArray[optionSelected]);
		remove(background);
		optionsArray = null;
		optionsStringArray = null;
		background = null;
		super.destroy();
	}



	override public function update():Void
	{
		updateOption();
		#if desktop
			if (FlxG.keys.justPressed.UP)
			{
				optionSelected = (optionSelected + numberOfOptions - 1) % numberOfOptions;
				//FlxG.sound.play("assets/sounds/menu" + Reg.SoundExtension, 1, false);
			}
			if (FlxG.keys.justPressed.DOWN)
			{
				optionSelected = (optionSelected + numberOfOptions + 1) % numberOfOptions;
				//FlxG.sound.play("assets/sounds/menu" + Reg.SoundExtension, 1, false);
			}

			if (FlxG.keys.anyJustPressed(["SPACE", "ENTER", "C"]))
			{
				switch (optionSelected)
				{
				case 0:
					FlxG.cameras.fade(FlxColor.WHITE, 1, false, startGame);
				case 1:
					
				case 2:
					FlxG.openURL("http://github.com/fiddenmar/colourjump2");
				case 3:
					System.exit(0);
				}
			}
		#elseif mobile
			for (touch in FlxG.touches.list)
			{
			    if (touch.justPressed)
			    {
			    	if (touch.screenY < FlxG.height * 3 / 8)
			    	{
			    		optionSelected = (optionSelected + numberOfOptions - 1) % numberOfOptions;
			    		//FlxG.sound.play("assets/sounds/menu" + Reg.SoundExtension, 1, false);
			    	}
			    	else if (touch.screenY > FlxG.height * 5 / 8)
			    	{
			    		optionSelected = (optionSelected + numberOfOptions + 1) % numberOfOptions;
			    		//FlxG.sound.play("assets/sounds/menu" + Reg.SoundExtension, 1, false);
			    	}
			    	else
			    	{
			    		switch (optionSelected)
						{
						case 0:
							FlxG.cameras.fade(FlxColor.WHITE, 1, false, startGame);
						case 1:
							
						case 2:
							FlxG.openURL("http://github.com/fiddenmar/colourjump2");
						case 3:
							System.exit(0);
						}
			    	}
			    }
			}
		#end

		super.update();
	}

	private function startGame():Void
	{
		FlxG.switchState(new PlayState());
	}	
}