import 'package:dio/dio.dart';
import '../models/user.dart';

Future<List<User>?> getUsers() async {
  try {
    var url = 'https://jsonplaceholder.typicode.com/users';
    var res = await Dio().get(url);
    if (res.statusCode == 200) {
      var body = res.data as List;
      return body.map((e) => User.fromJson(e)).toList();
    }
    // ignore: avoid_print
    print(res.statusCode);
  } catch (e) {
    // ignore: avoid_print
    print('Sehv var: $e');
  }
  return [];
}
