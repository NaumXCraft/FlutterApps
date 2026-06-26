### 1. **AppBar**

Верхняя панель приложения (шапка), где обычно отображается заголовок, кнопки навигации и действий.

```dart
AppBar(title: Text("Главная страница"))
```

---

### 2. **ThemeData**

Класс, определяющий визуальный стиль всего приложения (цвета, шрифты, иконки).

```dart
ThemeData(primarySwatch: Colors.blue)
```

---

### 3. **Material**

Виджет-обёртка, который включает стили и поведение согласно Material Design (визуальный язык от Google).

```dart
Material(child: Text("Привет"))
```

---

### 4. **ListView**

Скроллируемый список элементов (вертикально или горизонтально).

```dart
ListView(children: [Text("Элемент 1"), Text("Элемент 2")])
```

---

### 5. **Scaffold**

Базовая структура страницы: включает AppBar, Drawer, Body, BottomNavigation и др.

```dart
Scaffold(appBar: AppBar(title: Text("Заголовок")), body: Text("Контент"))
```

---

### 6. **Text**

Виджет для отображения текста.

```dart
Text("Привет, мир")
```

---

### 7. **Column**

Располагает дочерние виджеты вертикально.

```dart
Column(children: [Text("1"), Text("2")])
```

---

### 8. **Padding**

Добавляет отступы вокруг дочернего виджета.

```dart
Padding(
  padding: EdgeInsets.all(8.0),
  child: Text("С отступом")
)
```

---

Хорошо, вот продолжение твоего справочника:

---

### 9. **Row**

Располагает дочерние виджеты горизонтально.

```dart
Row(children: [Text("Слева"), Text("Справа")])
```

---

### 10. **SizedBox**

Пустой виджет, используется для создания пространства между элементами.

```dart
SizedBox(height: 10)
```

---

### 11. **TextField**

TextField — это виджет (widget), который позволяет пользователю вводить текст в приложении. 
Это основной способ текстового ввода, используется в формах, чатах, полях поиска и т.п.

```dart
TextField(decoration: InputDecoration(labelText: "Введите имя"))
```

---

### 12. **InputDecoration**

Настройка внешнего вида `TextField`.

```dart
InputDecoration(
  border: OutlineInputBorder(),
  hintText: "Введите пароль"
)
```

---

### 13. **OutlineInputBorder**

Граница вокруг поля ввода.

```dart
OutlineInputBorder(borderRadius: BorderRadius.circular(8))
```

---

### 14. **ElevatedButton**

Кнопка с фоном и тенью (по стандарту Material Design).

```dart
ElevatedButton(
  onPressed: () {},
  child: Text("Нажми меня")
)
```

---

### 15. **TextButton**

Плоская текстовая кнопка без фона.

```dart
TextButton(
  onPressed: () {},
  child: Text("Ссылка")
)
```

---

### 16. **foregroundColor / backgroundColor**

Цвет текста и фона для кнопок.

```dart
ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.blue
)
```

---

### 17. **RoundedRectangleBorder**

Скруглённые углы, обычно для кнопок.

```dart
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
```

---

### 18. **EdgeInsets**

Задаёт внутренние отступы (padding).

```dart
EdgeInsets.symmetric(horizontal: 16, vertical: 8)
```

---

### 19. **StatefulWidget**

Виджет, который может изменять своё состояние при взаимодействии.

```dart
class MyWidget extends StatefulWidget { ... }
```

---

### 20. **StatelessWidget**

Виджет без состояния, используется для неизменяемого UI.

```dart
class MyWidget extends StatelessWidget { ... }
```

---

Хорошо, продолжаем:

---

### 21. **Navigator**

Управляет переходами между экранами (страницами) в приложении.

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NextPage()),
)
```

---

### 22. **Container**

Основной контейнер, который может содержать другие виджеты, а также настраивать их размеры, отступы, цвет и т.д.

```dart
Container(
  color: Colors.blue,
  padding: EdgeInsets.all(16),
  child: Text("Внутри контейнера"),
)
```

---

### 23. **Expanded**

Позволяет дочерним элементам занимать доступное пространство внутри `Row`, `Column` или `Flex`.

```dart
Row(
  children: [
    Text("Первый элемент"),
    Expanded(child: Text("Расширенный элемент")),
  ],
)
```

---

### 24. **Flexible**

Похож на `Expanded`, но позволяет более точно контролировать, сколько пространства должно занять дочернее содержимое.

```dart
Row(
  children: [
    Text("Первый элемент"),
    Flexible(flex: 2, child: Text("Гибкий элемент")),
  ],
)
```

---

### 25. **ListView\.builder**

Скроллируемый список с динамически создаваемыми элементами.

```dart
ListView.builder(
  itemCount: 10,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text("Элемент $index"),
    );
  },
)
```

---

### 26. **GestureDetector**

Обработчик жестов, например, нажатия, прокрутки, свайпов.

```dart
GestureDetector(
  onTap: () {
    print("Кнопка нажата");
  },
  child: Container(color: Colors.blue, height: 50, width: 100),
)
```

---

### 27. **Stack**

Позволяет накладывать виджеты друг на друга.

```dart
Stack(
  children: [
    Positioned(
      top: 50,
      left: 50,
      child: Text("Текст в центре"),
    ),
    Positioned(
      top: 100,
      left: 100,
      child: Text("Другой текст"),
    ),
  ],
)
```

---

### 28. **Icon**

Отображает иконку.

```dart
Icon(Icons.home, color: Colors.blue)
```

---

### 29. **FutureBuilder**

Для асинхронной загрузки данных и отображения их при завершении.

```dart
FutureBuilder<String>(
  future: fetchData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Ошибка: ${snapshot.error}');
    }
    return Text('Данные: ${snapshot.data}');
  },
)
```

---

### 30. **StreamBuilder**

Для работы с потоками данных (например, обновление UI при изменении данных).

```dart
StreamBuilder<int>(
  stream: streamData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      return Text('Текущий поток: ${snapshot.data}');
    }
    return CircularProgressIndicator();
  },
)
```

---

### 31. **AlertDialog**

Диалоговое окно с кнопками.

```dart
AlertDialog(
  title: Text("Предупреждение"),
  content: Text("Вы уверены, что хотите выйти?"),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text("Отмена"),
    ),
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text("Ок"),
    ),
  ],
)
```

---

### 32. **Form**

Форма для группировки и валидации полей ввода.

```dart
Form(
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: "Имя"),
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text("Отправить"),
      ),
    ],
  ),
)
```

---

### 33. **ScaffoldMessenger**

Отображение сообщений (например, snackbar) в приложении.

```dart
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Это сообщение")));
```

---

### 34. **Hero**

Анимация перехода между экранами для виджетов с одинаковым тегом.

```dart
Hero(
  tag: 'hero-tag',
  child: Image.asset('assets/image.png'),
)
```

---

### 35. **MediaQuery**

Получение информации о размере экрана и других характеристиках устройства.

```dart
MediaQuery.of(context).size.height
```

---

