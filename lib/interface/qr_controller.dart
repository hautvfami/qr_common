/**
 * Created by HauTran on 22/06/2021.
 * hautv.fami@gmail.com
 */
import 'dart:async';

import 'package:common/core/enum.dart';

abstract class QrController {
  FlashState flashState = FlashState.off;
  CameraFacing cameraFacing = CameraFacing.back;
  CameraState cameraState = CameraState.prepare;

  ///restart the camera
  Future<void>? restart();

  ///toggle flash
  Future<void>? toggleFlash();

  ///turn on flash
  Future<void>? turnOnFlash();

  ///turn off flash
  Future<void>? turnOffFlash();

  ///switch camera
  Future<void>? switchCamera();

  ///switch camera to back
  Future<void>? switchCameraToBack();

  ///switch camera to front
  Future<void>? switchCameraToFront();

  ///stop camera
  Future<void>? stop();
}
