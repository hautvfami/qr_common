//
// Created by HauTV3 on 6/26/21.
// Copyright (c) 2021 OMG. All rights reserved.
//

import 'package:flutter/material.dart';

abstract class LifecycleState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver, RouteAware {
  /// RouteObserver [routeObserver] needed to tracking widget
  /// is on top of Navigator tree or not
  RouteObserver<ModalRoute> get routeObserver;

  bool _isOnTop = true;

  @mustCallSuper
  void onResume() {}

  @mustCallSuper
  void onPause() {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_isOnTop) onResume();
    } else {
      onPause();
    }
  }

  @override
  void didPushNext() {
    _isOnTop = false;
    onPause();
    super.didPush();
  }

  @override
  void didPopNext() {
    _isOnTop = true;
    onResume();
    super.didPopNext();
  }
}
