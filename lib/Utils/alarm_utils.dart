String addZero(int value) {
  return value < 10 ? "0$value" : value.toString();
}
