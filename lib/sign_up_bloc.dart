import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final _passwordStream = StreamController<String>.broadcast();
  final _emailStream = StreamController<String>.broadcast();

  Stream<String> get email => _emailStream.stream.transform(emailTransform);

  Stream<String> get password =>
      _passwordStream.stream.transform(passwordTransform);

  Stream<bool> get submitValue =>
      CombineLatestStream.combine2(email, password, (email, password) => true);

  Function(String) get addPassword => _passwordStream.sink.add;

  Function(String) get addEmail => _emailStream.sink.add;

  final emailTransform = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, eventSink) {
    if (email.trim().contains('@')) {
      eventSink.add(email.trim());
    } else {
      eventSink.addError('Enter a valid email');
    }
  });

  final passwordTransform = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, eventSink) {
    if (password.length > 6) {
      eventSink.add(password);
    } else {
      eventSink.addError('Password should be >6 chars');
    }
  });

  void dispose() {
    _passwordStream.close();
    _emailStream.close();
  }
}
