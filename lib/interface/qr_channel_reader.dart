//
// Created by HauTV3 on 6/23/21.
// Copyright (c) 2021 OMG. All rights reserved.
//

import 'package:common/core/method_const.dart';
import 'package:flutter/services.dart';

typedef void QRCodeHandler(String? qr);

class QrChannelReader {
  MethodChannel channel;
  QRCodeHandler? qrCodeHandler;

  QrChannelReader(this.channel) {
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case MethodConst.callFromNativeScanResult:
          if (qrCodeHandler != null && call.arguments is String) {
            qrCodeHandler!(call.arguments);
          }
          break;
        default:
          print("Unknown method call: ${call.method}");
      }
    });
  }

  void setQrCodeHandler(QRCodeHandler? qrch) => this.qrCodeHandler = qrch;
}
