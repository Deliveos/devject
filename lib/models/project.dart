import 'package:projetex/models/user.dart';

class Project {
  final int? id;
  final int? ownerId;
  final String name;
  final List<User> responsible;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final int progress;

  Project({
    this.id,
    required this.responsible,
    this.ownerId, 
    required this.name, 
    this.description,
    this.startDate, 
    this.endDate, 
    this.progress = 0});



  static Project fromMap(Map<String, dynamic> map) => Project(
    id:  map['id'],
    ownerId: map['owner_id'],
    name: map['name'], 
    responsible: [],
    description: map['description'],
    startDate: null, // DateTime.fromMillisecondsSinceEpoch(map['start_date']),
    endDate: null, // DateTime.fromMillisecondsSinceEpoch(map['end_date']),
    progress: map['progress']
  );

  Map<String, dynamic> toMap() =>  <String, dynamic>{
    "id": id,
    "name": name,
    "description": description,
    "start_date": startDate?.millisecondsSinceEpoch ,
    "end_date": endDate?.millisecondsSinceEpoch,
    "progress": progress
  };
}