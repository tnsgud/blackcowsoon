/* TODO:
 1.데이터 저장되게 만들기
 2.디자인 바꾸기*/
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// 할 일 클래스
class Todo {
  bool isDone = false;
  String title;

  Todo(this.title);
}

// 시작 클래스
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할 일 관리',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoListPage(),
    );
  }
}

// TodoListPage 클래스
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

//TodoListPage의 State 클래스
class _TodoListPageState extends State<TodoListPage> {
  // 할 일 목록을 저장할 리스트
  final _items = <Todo>[];

  bool iconchager = true;

  // 할 일 문자열 조작을 위한 컨트롤러
  var _todoController = TextEditingController();

  // 할 일 추가 메서드
  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = '';
    });
  }

  // 할 일 삭제 메서드
  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  // 할 일 완료/미완료 메서드
  void _toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  @override
  void dispose() {
    _todoController.dispose(); //사용이 끝나면 해체
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _todoController,
                )),
                IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.add),
                    onPressed: () => _addTodo(Todo(_todoController.text)))
              ],
            ),
            Expanded(
                child: ListView(
                    children:
                        _items.map((todo) => _buildItemWidget(todo)).toList()))
          ],
        ),
      ),
    );
  }

  // 할 일 객체를 ListTile 형태로 변경하는 메서드
  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      leading: Icon(
        iconchager ? Icons.radio_button_unchecked : Icons.radio_button_checked,
        color: Colors.blue,
      ),
      onTap: () {
        setState(() {
          if (iconchager == true) {
            iconchager = false;
          } else {
            iconchager = true;
          }
          _toggleTodo(todo);
        });
      },
      title: Text(
        todo.title, //할 일
        style: todo.isDone
            ? // 완료인 때는 스타일 적용
            TextStyle(
                decoration: TextDecoration.lineThrough, //취소선
                fontStyle: FontStyle.italic //이탤릭체
                )
            : null, //아무 스타일도 적용 안 함
      ),
      trailing: IconButton(
          color: Colors.blue,
          icon: Icon(Icons.delete_forever),
          onPressed: () => _deleteTodo(todo)), //삭제
    );
  }
}
