class Author {
  final String id;
  final String name;
  final String birthDate;
  final String deathDate;
  final String topWork;

  Author({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.deathDate,
    required this.topWork,
  });
}

class Work {
  final String title;

  Work({required this.title});
}
