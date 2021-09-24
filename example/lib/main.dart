import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';

Future<void> main() async {
  /// Wait until the platform channel is properly initialized so we can call
  /// `setContext` during the app initialization.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final time = DateTime.now().toUtc().millisecondsSinceEpoch;
  SegmentDefaultOptions.instance.options = {
    'integrations': {
      'Amplitude': {
        'session_id': '$time',
      },
    }
  };

  /// The `context.device.token` is a special property.
  /// When you define it, setting the context again with no token property (ex: `{}`)
  /// has no effect on cleaning up the device token.
  ///
  /// This is used as an example to allow you to set string-based
  /// device tokens, which is the use case when integrating with
  /// Firebase Cloud Messaging (FCM).
  ///
  /// This plugin currently does not support Apple Push Notification service (APNs)
  /// tokens, which are binary structures.
  ///
  /// Aside from this special use case, any other context property that needs
  /// to be defined (or re-defined) can be done.
  Segment.setContext({
    'device': {
      'token': 'testing',
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Segment.screen(
      screenName: 'Example Screen',
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Segment example app'),
        ),
        body: Column(
          children: <Widget>[
            Spacer(),
            Center(
              child: FlatButton(
                child: Text('track WITH SEGMENT'),
                onPressed: () {
                  Segment.track(
                    eventName: 'test',
                    properties: {
                      'value': 'test_value',
                      // 'number': 1337,
                      // 'clicked': true,
                    },
                  );
                },
              ),
            ),
            Spacer(),
            Center(
              child: FlatButton(
                child: Text('identify WITH SEGMENT'),
                onPressed: () {
                  Segment.identify(userId: '1', options: {}, traits: {});
                },
              ),
            ),
            Spacer(),
            Center(
              child: FlatButton(
                child: Text('Update Context'),
                onPressed: () {
                  Segment.setContext({'custom': 123});
                },
              ),
            ),
            Spacer(),
            Center(
              child: FlatButton(
                child: Text('Clear Context'),
                onPressed: () {
                  Segment.setContext({});
                },
              ),
            ),
            Spacer(),
            Center(
              child: FlatButton(
                child: Text('Disable'),
                onPressed: () async {
                  await Segment.disable();
                  Segment.track(eventName: 'This event will not be logged');
                },
              ),
            ),
            Spacer(),
            Center(
              child: FlatButton(
                child: Text('Enable'),
                onPressed: () async {
                  await Segment.enable();
                  Segment.track(eventName: 'Enabled tracking events!');
                },
              ),
            ),
            Spacer(),
            Platform.isIOS
                ? Center(
                    child: FlatButton(
                      child: Text('Debug mode'),
                      onPressed: () {
                        Segment.debug(true);
                      },
                    ),
                  )
                : Container(),
            Spacer(),
          ],
        ),
      ),
      navigatorObservers: [
        SegmentObserver(),
      ],
    );
  }
}
