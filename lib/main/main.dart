library main;

import 'dart:async';

import 'package:bridge/bridge.dart';
import '../app.dart';

/// This is the entry point to the transport layer of the application.
/// It's where tether calls and HTTP routes are delegated to controllers.
///
/// Note that the same controller instance will be used for all requests.
class Main {
  final Repository<ChatMessage> messages;

  Main(this.messages);

  routes(Router router) {
    router.get('/', () {
      return template('index').withScript('main')
        ..messages = messages.all();
    });
  }

  tether(Tether tether, TetherManager manager) {
    tether.listen('newMessage', (ChatMessage message) async {
      await messages.add(message);
      // broadcast to every client
      manager.broadcast('displayMessage', message);
    });
  }
}
