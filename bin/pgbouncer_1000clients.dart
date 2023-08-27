import 'dart:isolate';

import 'package:postgres/postgres.dart';

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
  var connection = PostgreSQLConnection(
    "localhost",
    6432,
    "postgres",
    username: "app_user",
    password: "password",
  );
  await connection.open();
  for (var i = 0; i < 10; i++) {
    await connection.query("INSERT INTO api.todos (task, done) VALUES (@a, @b)",
        substitutionValues: {
          "a": 'some_task_name $i',
          'b': false,
        });
  }

  await connection.close();
}
