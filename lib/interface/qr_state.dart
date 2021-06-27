//
// Created by HauTV3 on 6/22/21.
// Copyright (c) 2021 OMG. All rights reserved.
//

import 'dart:developer';

import 'package:common/common.dart';
import 'package:common/interface/lifecycle_state.dart';
import 'package:common/interface/qr_channel_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class QRState<T extends StatefulWidget> extends LifecycleState<T>
    implements QrController {
  static const MethodChannel _channel = MethodChannel(MethodConst.channel);
  static QrChannelReader _channelReader = QrChannelReader(_channel);

  FlashState flashState = FlashState.off;
  CameraFacing cameraFacing = CameraFacing.back;
  CameraState cameraState = CameraState.start;
  Size previewSize = Size(0, 0);

  Future<PreviewDetails>? asyncInitOnce;

  void codeResultHandler(String? qr);

  List<Symbology> get formats;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    asyncInit();
  }

  Future<PreviewDetails>? asyncInit() {
    if (asyncInitOnce != null) return asyncInitOnce;
    previewSize = MediaQuery.of(context).size;
    var previewDetails = this.start(
      width: previewSize.width.toInt(),
      height: previewSize.height.toInt(),
      qrCodeHandler: codeResultHandler,
      formats: formats,
      camera2Enabled: true,
    );
    asyncInitOnce = previewDetails;
    return previewDetails;
  }

  @override
  Future? toggleFlash() => _channel.invokeMethod(MethodConst.nativeToggleFlash);

  @override
  Future? turnOnFlash() => _channel.invokeMethod(MethodConst.nativeTurnOnFlash);

  Future? turnOffFlash() =>
      _channel.invokeMethod(MethodConst.nativeTurnOffFlash);

  Future? switchCamera() =>
      _channel.invokeMethod(MethodConst.nativeSwitchCamera);

  Future? switchCameraToBack() =>
      _channel.invokeMethod(MethodConst.nativeSwitchCamera2Back);

  Future? switchCameraToFront() =>
      _channel.invokeMethod(MethodConst.nativeSwitchCamera2Front);

  /// Only scanner
  Future heartbeat() => _channel.invokeMethod(MethodConst.nativeHeartbeat);

  /// Only scanner
  static Future<List<List<int>>?> getSupportedSizes() {
    return _channel
        .invokeMethod(MethodConst.nativeGetSupportedSizes)
        .catchError(print)
        .then((value) => value as List<List<int>>?);
  }

  Future? stop() {
    _channelReader.setQrCodeHandler(null);
    _channel.invokeMethod(MethodConst.nativeStopCapturing);
  }

  Future<PreviewDetails>? start({
    required int width,
    required int height,
    required QRCodeHandler qrCodeHandler,
    List<Symbology>? formats = const [Symbology.QR],
    bool camera2Enabled = false,
  }) async {
    _channelReader.setQrCodeHandler(qrCodeHandler);
    var details =
        await _channel.invokeMethod(MethodConst.nativeStartCapturing, {
      Param.targetWidth: width,
      Param.targetHeight: height,
      Param.heartbeatTimeout: 0,
      Param.formats: formats?.map((e) => e.stringify).toList(),
      Param.camera2Enabled: camera2Enabled,
    });

    int? textureId = details[Param.textureId];
    num? orientation = details[Param.surfaceOrientation];
    num? surfaceHeight = details[Param.surfaceHeight];
    num? surfaceWidth = details[Param.surfaceWidth];

    return PreviewDetails(
      surfaceWidth,
      surfaceHeight,
      orientation,
      textureId,
    );
  }

  Future? restart() async {
    await this.stop();
    asyncInitOnce = null;
    await this.asyncInit();
    this.setState(() {});
  }

  @override
  void deactivate() {
    this.stop();
    asyncInitOnce = null;
    super.deactivate();
  }

  @override
  void dispose() {
    this.stop();
    asyncInitOnce = null;
    super.dispose();
  }

  @override
  void onPause() {
    log('', name: 'QRState' + '.onPause');
    stop();
    super.onPause();
  }

  @override
  void onResume() {
    log('', name: 'QRState' + '.onResume');
    restart();
    super.onResume();
  }
}
