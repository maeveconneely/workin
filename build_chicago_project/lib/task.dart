class Task {
  final String name;
  final String finalDestination;
  final String groceryStore;
  final String groceries;

  Task(this.name, this.finalDestination, this.groceryStore,
  this.groceries);

  Task.fromJson(Map<String, dynamic> json)
  : name = json["name"],
  finalDestination = json["finalDestination"],
  groceryStore = json["groceryStore"],
  groceries = json["groceries"];

  String groceriesString() {
    String str = "";
    for (int i = 0; i < groceries.length; i++) {
      str += groceries[i] + ", ";
    }
    return str;
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'finalDestination': finalDestination,
    'groceryStore': groceryStore,
    'groceries': groceries
  };

  factory Task.fromMap(Map<String, dynamic> parsedJson) {
    return Task(
      parsedJson['name'],
      parsedJson['finalDestination'],
      parsedJson['groceryStore'],
      parsedJson['groceries']
    );
  }

}