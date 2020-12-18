class Person {
  String name;
  String job;
  String image;
  String text;

  Person({this.name, this.job, this.image, this.text});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'].toString(),
      job: json['job'].toString(),
      image: json['image'].toString(),
      text: json['text'].toString(),
    );
  }
}
