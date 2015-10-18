library migrations;

import 'dart:async';
import 'package:bridge/database.dart';

class CreateChatMessagesTable extends Migration {
  @override
  Future run(Gateway gateway) async {
    await gateway.create('chat_messages', (schema) {
      schema.string('content');
    });
  }

  @override
  Future rollback(Gateway gateway) async {
    await gateway.drop('chat_messages');
  }
}