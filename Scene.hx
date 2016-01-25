package haxepistols;

import haxepistols.HXP;
import away3d.entities.Mesh;

class Scene {

  public function new () {
    begin();
  }

  public function begin () {

  }

  public function addGraphic (mesh:Mesh) {
    HXP.view.scene.addChild(mesh);
  }

  public function update () {
  }
}
