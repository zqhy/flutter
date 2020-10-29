class ReturnRouterInfo {
  final String name;
  final Object arguments;

  ReturnRouterInfo(this.name, this.arguments);

  ReturnRouterInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        arguments = json['arguments'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'arguments': arguments,
      };
}