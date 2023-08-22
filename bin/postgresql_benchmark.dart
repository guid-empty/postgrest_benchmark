import 'package:postgres/postgres.dart';

Future<void> main() async {
  var connection = PostgreSQLConnection(
    "localhost",
    5432,
    "postgres",
    username: "app_user",
    password: "password",
  );
  await connection.open();

  // List<List<dynamic>> results =
  //     await connection.query("SELECT task, done FROM api.todos");
  //
  final watch = Stopwatch();
  watch.start();
  try {
    for (var i = 0; i < 10000; i++) {
      await connection.query(
          "INSERT INTO api.todos (task, done) VALUES (@a, @b)",
          substitutionValues: {
            "a": 'some_task_name $i',
            'b': false,
          });
    }
  } catch (error, stacktrace) {
    print('$error \n $stacktrace');
  }
  watch.stop();
  print('total to insert 10000 records ${watch.elapsedMilliseconds}');
}
