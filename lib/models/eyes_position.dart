class EyesPosition {
  int left;
  int right;

  EyesPosition(this.left, this.right);

  double average() {
    return left + right / 2;
  }

  operator -(EyesPosition other) {
    return average() - other.average();
  }
}
