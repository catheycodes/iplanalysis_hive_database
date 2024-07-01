import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 0)
class Player extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int matches;

  @HiveField(2)
  int runs;

  @HiveField(3)
  int wickets;

  @HiveField(4)
  int outs;

  Player({
    required this.name,
    required this.matches,
    required this.runs,
    required this.wickets,
    required this.outs,
  });

  double get battingAverage => outs != 0 ? runs / outs.toDouble() : 0.0;
  double get score => runs  / matches;

  @override
  String toString() {
    return 'Player{name: $name, matches: $matches, runs: $runs, wickets: $wickets, outs: $outs}';
  }
}
