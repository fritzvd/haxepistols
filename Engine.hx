package haxepistols;

import away3d.containers.View3D;
import away3d.debug.*;

import openfl.display.StageScaleMode;
import openfl.display.StageAlign;
import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.Lib;
import haxe.Timer;

class Engine extends Sprite
{
	public var _view:View3D;
	public var _scene:Scene;

	/**
	 * Constructor
	 */
	public function new ()
	{
		super();

		HXP.engine = this;

		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.align = StageAlign.TOP_LEFT;

		_view = new View3D();
		init();

		HXP.view = _view;

		//setup the render loop
	 	_view.setRenderCallback(_onEnterFrame);
		Lib.current.addChild(_view);

		Lib.current.stage.addEventListener(Event.RESIZE, onResize);
		onResize();

		// stats
#if debug
		Lib.current.addChild(new away3d.debug.AwayFPS(HXP.view, 10, 10, 0xffffff, 3));
#end
	}

	public function init () {
		// override scene or something here
		_scene = new Scene();
	}

	/**
	 * render loop
	 */
	private static var ctr:Float = 0;
	private function _onEnterFrame(e:Event):Void
	{
		_scene.update();
		_view.render();
	}

	/**
	 * Lib.current.stage listener for resize events
	 */
	private function onResize(event:Event = null):Void
	{
		_view.width = Lib.current.stage.stageWidth;
		_view.height = Lib.current.stage.stageHeight;
	}
}
