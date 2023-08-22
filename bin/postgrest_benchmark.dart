import 'package:postgrest/postgrest.dart';

Future<void> main() async {
  final url = 'http://127.0.0.1:3000';
  final client = PostgrestClient(url);

  // //  reading the data
  // final response = await client.from('todos').select();

  final watch = Stopwatch();
  watch.start();
  try {
    for (var i = 0; i < 10000; i++) {
      await client.from('todos').insert(
        {'task': 'some_task_name $i', 'done': false},
      );
    }
  } on PostgrestException catch (error, stacktrace) {
    print('$error \n $stacktrace');
  } catch (error, stacktrace) {
    print('$error \n $stacktrace');
  }
  watch.stop();
  print('total to insert 10000 records ${watch.elapsedMilliseconds}');
}
