package haxepistols.cameras;

import away3d.controllers.FirstPersonController;
import away3d.cameras.Camera3D;
import openfl.display.Stage;
import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.events.Event;
import openfl.ui.Keyboard;
import openfl.geom.Vector3D;

class FirstPersonCamera {
  private var stage:Stage;
  private var cameraController:FirstPersonController;

  private var moving:Bool = false;
  private var lastPanAngle:Float;
  private var lastTiltAngle:Float;
  private var lastMouseX:Float = 0;
  private var lastMouseY:Float = 0;

  // movement variables
  private var drag:Float = 0.5;
  private var walkIncrement:Float = 2;
  private var strafeIncrement:Float = 2;
  private var walkSpeed:Float = 0;
  private var strafeSpeed:Float = 0;
  private var walkAcceleration:Float = 0;
  private var strafeAcceleration:Float = 0;
  private var _camera:Camera3D;

  private var mouseSpeed:Float = 0.3;

  public function new (camera:Camera3D) {
    stage = Lib.current.stage;
    _camera = camera;

    camera.z = -600;
    camera.y = 200;
    camera.lookAt(new Vector3D());

    cameraController = new FirstPersonController(camera, 180, 0, -80, 80);
    // stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
    stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
    stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);

    stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
    stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
  }

  private function mouseDownHandler(event:MouseEvent) {
      // stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
      trace(event);

      // indicate camera is moving and set state variables
      moving = true;

      lastPanAngle = cameraController.panAngle;
      lastTiltAngle = cameraController.tiltAngle;
      lastMouseX = stage.mouseX;
      lastMouseY = stage.mouseY;
  }

  private function mouseMoveHandler(event:MouseEvent) {
      // stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
      trace(event);
      // indicate camera is moving and set state variables
      moving = true;

      lastPanAngle = cameraController.panAngle;
      lastTiltAngle = cameraController.tiltAngle;
      lastMouseX = stage.mouseX;
      lastMouseY = stage.mouseY;
  }
  /**
   *
   */
  private function mouseUpHandler(event:MouseEvent) {
      // stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);

      moving = false;
  }

  /**
   *
   */
  private function mouseLeaveHandler(event:Event) {
      // stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);

      moving = false;
  }

  private function keyDownHandler(event:KeyboardEvent) {
    switch (event.keyCode) {
      // full screen
    // case Keyboard.F:
    //   // fullScreen(false);
    //   break;

    case Keyboard.UP:
    case Keyboard.W:
      walkAcceleration = walkIncrement;
    case Keyboard.DOWN:
    case Keyboard.S:
      walkAcceleration = -walkIncrement;
    case Keyboard.LEFT:
    case Keyboard.A:
      strafeAcceleration = -strafeIncrement;
    case Keyboard.RIGHT:
    case Keyboard.D:
      strafeAcceleration = strafeIncrement;
    }
  }

  /**
  *
  */
  private function keyUpHandler(event:KeyboardEvent) {
    // switch (event.keyCode) {
    // case Keyboard.UP:
    // case Keyboard.W:
    // case Keyboard.DOWN:
    // case Keyboard.S:
      walkAcceleration = 0;
    // case Keyboard.LEFT:
    // case Keyboard.A:
    // case Keyboard.RIGHT:
    // case Keyboard.D:
      strafeAcceleration = 0;
    // }
  }
  /**
  *
  */
  private function mouseWheelHandler(event:MouseEvent) {
  }

  public function update() {
    // _camera.update();
    if (moving) {
      cameraController.panAngle = mouseSpeed * (stage.mouseX - lastMouseX) + lastPanAngle;
      cameraController.tiltAngle = mouseSpeed * (stage.mouseY - lastMouseY) + lastTiltAngle;
    }

    if (walkSpeed != 0 || walkAcceleration != 0) {
      walkSpeed = (walkSpeed + walkAcceleration) * drag;
      if (Math.abs(walkSpeed) < 0.01)
      walkSpeed = 0;
      cameraController.incrementWalk(walkSpeed);
    }

    if (strafeSpeed != 0 || strafeAcceleration != 0) {
      strafeSpeed = (strafeSpeed + strafeAcceleration) * drag;
      if (Math.abs(strafeSpeed) < 0.01)
      strafeSpeed = 0;
      cameraController.incrementStrafe(strafeSpeed);
    }
  }

}
