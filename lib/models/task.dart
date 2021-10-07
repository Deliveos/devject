class Task {
  Task({
    required this.name, 
    required this.responsible, 
    this.description, 
    this.start, 
    this.startWhenFinished, 
    this.end});

  final String name;
  final List responsible;
  final String? description;
  final DateTime? start;
  final Task? startWhenFinished;
  final DateTime? end;

}