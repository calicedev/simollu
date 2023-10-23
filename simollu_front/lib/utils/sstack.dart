class Sstack<T> {
  final List<T> _items;

  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  Sstack(this._items);

  void push(T item) {
    _items.add(item);
  }

  T pop() {
    if (_items.isEmpty) throw Exception("Stack is empty");
    return _items.removeLast();
  }

  T peek() {
    if (_items.isEmpty) throw Exception("Stack is empty");
    return _items.last;
  }

  void clear() {
    _items.clear();
  }
}
