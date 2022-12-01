import 'package:hive/hive.dart';
import 'package:ninja_demo/model/cat.dart';
import 'package:path_provider/path_provider.dart';

class CatService {
  late Box<Cat> _tasks;

  Future<void> init() async {
    Hive
      ..init((await getApplicationDocumentsDirectory()).path)
      ..registerAdapter(CatAdapter());
    _tasks = await Hive.openBox<Cat>('cats');
  }

  List<Cat> getTasks() {
    final tasks = _tasks.values;
    return tasks.toList();
  }

  Future<void> addTask(Cat cat) async {
    cat.index ??= DateTime.now().millisecondsSinceEpoch.toString();
    await _tasks.put(cat.index, cat);
  }

  Future<void> removeTask(String index) async {
    await _tasks.delete(index);
  }

  Future<void> updateTask(Cat cat) async {
    await _tasks.put(cat.index, cat);
  }
}
