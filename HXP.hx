package haxepistols;

import away3d.containers.View3D;
// import haxepistols.Scene;

class HXP {
  public static var view(get, set):View3D;
  private static inline function get_view():View3D { return engine._view; }
	private static inline function set_view(value:View3D):View3D { return engine._view = value; }

  public static var scene(get, set):Scene;
  private static inline function get_scene():Scene { return engine._scene; }
  private static inline function set_scene(value:Scene):Scene { return engine._scene = value; }

  public static var engine:Engine;

}
