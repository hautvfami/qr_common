/**
 * Created by HauTran on 22/06/2021.
 * hautv.fami@gmail.com
 */

class MethodConst {
  static const String channel = "QR_CHANNEL";

  static const String errorNoLicence = "MISSING_LICENCE";
  static const String errorPermissionDenied = "CAMERA_PERMISSION_DENIED";
  static const String errorCameraInitialisation = "CAMERA_INIT_ERROR";
  static const String errorNoCamera = "NO_CAMERA";
  static const String errorUnknown = "UNKNOWN_ERROR";

  static const String nativeStopCameraNCapturing = "STOP_CAMERA_N_CAPTURING";
  static const String nativeStartCameraNCapturing = "START_CAMERA_N_CAPTURING";
  static const String nativeStartCapturing = "START_CAPTURING";
  static const String nativeStopCapturing = "STOP_CAPTURING";
  static const String nativeToggleFlash = "TOGGLE_FLASH";
  static const String nativeTurnOnFlash = "TURN_ON_FLASH";
  static const String nativeTurnOffFlash = "TURN_OFF_FLASH";
  static const String nativeBarcodeInfo = "BARCODE_INFO";
  static const String nativeSwitchCamera2Front = "SWITCH_CAMERA_2_FRONT";
  static const String nativeSwitchCamera2Back = "SWITCH_CAMERA_2_BACK";
  static const String nativeSwitchCamera = "SWITCH_CAMERA";
  static const String nativeGetSupportedSizes = "SUPPORTED_SIZE";
  static const String nativeHeartbeat = "HEARTBEAT";

  static const String callFromNativeScanResult = "CODE_RESULT";
  static const String callFromNativeScanDataArgument = "DATA";
  static const String callFromNativeScanSymbologyArgument = "SYMBOLOGY";
  static const String callFromNativeErrorCode = "ERROR_CODE";
  static const String callFromNativeUnforeseenError = "UNFORESEEN_ERROR";
}
