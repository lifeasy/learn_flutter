class HelloWorld {
  String _privateMember = "文本";
  double ratio = 10;
  set ratio(double value) {
    if (ratio != value) {
      ratio = value;
      print("set success");
    } else {
      print("not set");
    }
  }

  int publicMember = 0;
  _privateFunction() {
    return 1;
  }

  publicFunction() {
    return 0;
  }

  handleRefresh() {
    print("refresh");
  }
}

void main() {
  print("hellow world");
  HelloWorld he = HelloWorld();
  he.handleRefresh();
  print(he._privateFunction());
  print(he.ratio);
}
