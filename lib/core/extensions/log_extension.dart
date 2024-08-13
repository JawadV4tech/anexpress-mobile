import 'dart:developer' as devtools show log;

import 'package:anexpress/core/config/app_constants.dart';

extension Log on Object {
  void log() {
    if (isDebugLogEnabled) {
      devtools.log(toString());
    }
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}
