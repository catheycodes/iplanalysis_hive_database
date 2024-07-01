import 'package:flutter/material.dart';
import 'package:iplanalysis_hive_database/player.dart';


class PlayerStatsPage extends StatelessWidget {
  final Player? bestPlayer;
  final Player? bestAveragePlayer;
  final Player? bestWicketsPlayer;

  PlayerStatsPage({
    Key? key,
    required this.bestPlayer,
    required this.bestAveragePlayer,
    required this.bestWicketsPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best Players'),
        backgroundColor: Color(0xffec0a8e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bestPlayer != null) ...[
              Text(
                'Best Player: ${bestPlayer!.name}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Score: ${bestPlayer!.score.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
            ],
            if (bestAveragePlayer != null) ...[
              Text(
                'Player with Best Average: ${bestAveragePlayer!.name}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Batting Average: ${bestAveragePlayer!.battingAverage.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
            ],
            if (bestWicketsPlayer != null) ...[
              Text(
                'Player with Most Wickets: ${bestWicketsPlayer!.name}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Wickets: ${bestWicketsPlayer!.wickets}',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
