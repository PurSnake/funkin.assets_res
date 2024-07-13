
import funkin.play.notes.notestyle.ScriptedNoteStyle;
import flixel.graphics.frames.FlxAtlasFrames;

import funkin.data.animation.AnimationDataUtil;

import funkin.play.notes.Strumline;
import funkin.play.notes.NoteHoldCover;

import funkin.util.Constants;
import funkin.util.tools.StringTools;

import funkin.modding.module.ScriptedModule;
import funkin.util.Constants;

class PixelNoteStyle extends ScriptedNoteStyle
{
	public function new()
	{
		super("pixel"); //wow, PIXEL SPLASHES WHAAATT???????
	}

	var coolFrames = null;
	public override function buildNoteSplashSprite(target:NoteSplash):Void
	{
		buildFramees();

		target.frames = coolFrames;
		target.antialiasing = !_data.assets.noteSplash.isPixel;
		target.scale.set(_data.assets.noteSplash.scale, _data.assets.noteSplash.scale);
		target.updateHitbox();

		buildNoteSplashAnimations(target);
	}

	function buildFramees()
	{
		if (coolFrames == null)
			coolFrames = new FlxSprite().loadGraphic(Paths.image(getNoteSplashAssetPath(), getNoteSplashAssetLibrary()), true, 37, 37).frames;
	}

	override function buildNoteSplashAnimations(target:NoteSplash):Void
	{
		target.animation.add('splash1Left', [0, 1, 2, 3], 12, false); target.animation.add('splash2Left', [4, 5, 6, 7], 12, false);

		target.animation.add('splash1Down', [8, 9, 10, 11], 12, false); target.animation.add('splash2Down', [12, 13, 14, 15], 12, false);

		target.animation.add('splash1Up', [24, 25, 26, 27], 12, false); target.animation.add('splash2Up', [28, 29, 30, 31], 12, false);

		target.animation.add('splash1Right', [16, 17, 18, 19], 12, false); target.animation.add('splash2Right', [20, 21, 22, 23], 12, false);
	}

	override function fetchNoteSplashAnimationData(dir, index) {} //nah

	override function getNoteSplashAnimationFrameRate(dir, index)
	{
		return 24;
	}

	var coolHoldsFrames = null;
	override function buildNoteHoldCoverSprite(target:NoteHoldCover):Void
	{
		buildNoteHoldCoverFrames(false);

		target.glow = new flixel.FlxSprite();
		target.add(target.glow);
		target.glow.frames = coolHoldsFrames;
		target.glow.alpha = 0.8;
		target.glow.antialiasing = !_data.assets.holdNoteCover.isPixel;
		target.glow.scale.set(_data.assets.holdNoteCover.scale, _data.assets.holdNoteCover.scale);
		target.glow.updateHitbox();
		target.glow.flipY = Preferences.downscroll;
		target.offset.set(-_data.assets.holdNoteCover.offsets[0], !Preferences.downscroll ? -_data.assets.holdNoteCover.offsets[1] : (-_data.assets.holdNoteCover.offsets[1] * .5));

		// Apply the animations.
		buildNoteHoldCoverAnimations(target);
	}

	override function buildNoteHoldCoverFrames(f)
	{
		if (coolHoldsFrames == null)
			coolHoldsFrames = new FlxSprite().loadGraphic(Paths.image(getNoteHoldCoverAssetPath(), getNoteHoldCoverAssetLibrary()), true, 15, 19).frames;
	}

	override function buildNoteHoldCoverAnimations(target:NoteHoldCover):Void
	{
		for (dir in 0...Strumline.DIRECTIONS.length)
		{
			var curLine = 5 * dir;
			var directionName = switch (dir)
			{
				case 0: "Purple"; case 1: "Blue"; case 3: "Green"; case 2: "Red";
			}
			target.glow.animation.add('holdCoverStart' + directionName, [0 + curLine, 1 + curLine, 2 + curLine], 24, false);
			target.glow.animation.add('holdCover' + directionName, [0 + curLine, 1 + curLine, 2 + curLine], 24, true);
			target.glow.animation.add('holdCoverEnd' + directionName, [3 + curLine, 4 + curLine], 24, false);

		}

		target.glow.animation.finishCallback = target.onAnimationFinished;
	}
}

class PixelNoteStyleStuff extends ScriptedModule
{
	function new() {
		super("PixelNoteStyle Stuff");
	}

	override function onCountdownEnd(event)
	{
		super.onCountdownEnd(event);
		for (strum in [PlayState.instance.playerStrumline, PlayState.instance.opponentStrumline])
		{
			if (strum.noteStyle.id != "pixel") continue;

			strum.holdNotesVwoosh.zIndex = strum.holdNotes.zIndex = 7;
			strum.noteHoldCovers.zIndex = 8;
			strum.refresh();
		}
	}
}
