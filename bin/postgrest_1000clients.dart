import 'dart:isolate';

import 'package:postgres/postgres.dart';
import 'package:postgrest/postgrest.dart';

Future<void> main() async {
  final watch = Stopwatch();
  watch.start();
  final futures = <Future<dynamic>>[];
  try {
    for (var i = 0; i < 1000; i++) {
      futures.add(Isolate.run(() => runClient(i)));
    }
    await Future.wait(futures);
  } catch (error, stacktrace) {
    print('$error \n $stacktrace');
  }
  watch.stop();
  print('total to insert 10000 records ${watch.elapsedMilliseconds}');
}

Future<void> runClient(int i) async {
  final url = 'http://127.0.0.1:3000';
  final client = PostgrestClient(url);

  for (var i = 0; i < 10; i++) {
    await client.from('todos').insert(
      {'task': 'some_task_name $i', 'done': false},
    );
  }
}
