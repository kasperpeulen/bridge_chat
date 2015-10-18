import 'package:bridge/bridge_client.dart';
import 'package:app/client.dart';
import 'dart:html';

/// This the example boilerplate of a client script file. Inject this
/// script into a template by using the following syntax in a controller.
///
///     return template('templateName').withScript('main');
///
/// A good practice would be to delegate the client script into your client
/// application in **lib/client** as neatly as possible.
main() async {
  // Register shared data structures
  registerTransport();
  
  // Connect the tether
  await globalTether();

  final UListElement messages = querySelector('#messages');
  final InputElement input = querySelector('#input');
  final ButtonElement submit = querySelector('#submit');

  submit.onClick.listen((_) {
    final message = new ChatMessage()
        ..content = input.value;
    input.value = '';

    tether.send('newMessage', message);
  });

  tether.listen('displayMessage', (ChatMessage message) {
    messages.append(new LIElement()..text = message.content);
  });
}