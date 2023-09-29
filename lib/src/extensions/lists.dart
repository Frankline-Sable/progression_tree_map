extension Lists<E> on List<E> {
  int get depth {
    int depth = 0;
    getElementDepth(List list) {
      depth++;
      for (var item in list) {
        if (item is List) {
          getElementDepth(item);
        }
      }
      return depth;
    }

    return getElementDepth(this);
  }
}
