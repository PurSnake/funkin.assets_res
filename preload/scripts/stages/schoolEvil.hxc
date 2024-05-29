import funkin.play.PlayState;
import funkin.play.stage.Stage;
import funkin.graphics.shaders.WiggleEffectRuntime;
import funkin.graphics.shaders.WiggleEffectType;
import flixel.addons.effects.FlxTrail;

import Math;
import funkin.Conductor;

class SchoolEvilStage extends Stage
{
	function new()
	{
		super('schoolEvil');
	}

	var wiggle:FlxRuntimeShader = null;

	override function buildStage()
	{
		super.buildStage();

		wiggle = new WiggleEffectRuntime(2, 4, 0.017, WiggleEffectType.DREAMY, true);

		getNamedProp('evilSchoolBG').shader = wiggle;
		getNamedProp('evilSchoolFG').shader = wiggle;

		PlayState.instance.camGame.addShader(wiggle);
		PlayState.instance.camHUD.addShader(wiggle);

	}

	var spin:Float = 4;
	override function addCharacter(char:BaseCharacter, charType:CharacterType)
	{
		// TODO: Once scripted characters are implemented, move this to the Spirit script.
		if (charType == charType.DAD)
		{
			var evilTrail = new FlxTrail(char, null, 4, 24, 0.3, 0.069);
			// Go behind Spirit.
			evilTrail.zIndex = 190;
			add(evilTrail);
		}

		super.addCharacter(char, charType);
	}

	override function onUpdate(event:UpdateScriptEvent) {
		super.onUpdate(event);

		if (wiggle != null) {
			wiggle.update(event.elapsed);
		}

		var songPos = Conductor.instance.songPosition / 1000; 
		PlayState.instance.camGame.angle = spin / 2 * Math.sin(songPos);
		PlayState.instance.camGame.y = spin / 2 * Math.sin(songPos);
		PlayState.instance.camHUD.angle = spin / 2 * Math.sin(songPos);

		//local songPos = getPropertyFromClass('grafex.system.Conductor', 'songPosition') / 1000 --How long it will take.
		//setProperty("camHUD.angle", spin * math.sin(songPos))
		//setProperty("camGame.angle", spin/2 * math.sin(songPos))
		//setProperty("camGame.y", spin*2 * math.sin(songPos))

		//var
	}

	function kill() {
		super.kill();
		wiggle = null;
	}
}
