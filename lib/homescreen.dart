import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:iplanalysis_hive_database/player.dart';
import 'package:iplanalysis_hive_database/player_details_page.dart';
import 'package:iplanalysis_hive_database/player_stats_page.dart';

class PlayerInputPage extends StatefulWidget {
  @override
  _PlayerInputPageState createState() => _PlayerInputPageState();
}

class _PlayerInputPageState extends State<PlayerInputPage> {
  final _formKey = GlobalKey<FormState>();
  final Box<Player> _playersBox = Hive.box<Player>('playersBox');
  final _nameController = TextEditingController();
  final _matchesController = TextEditingController();
  final _runsController = TextEditingController();
  final _wicketsController = TextEditingController();
  final _outsController = TextEditingController();
  bool _showStatsButton = false;

  void _addPlayer() {
    if (_formKey.currentState!.validate()) {
      final player = Player(
        name: _nameController.text,
        matches: int.parse(_matchesController.text),
        runs: int.parse(_runsController.text),
        wickets: int.parse(_wicketsController.text),
        outs: int.parse(_outsController.text),
      );

      _playersBox.add(player);

      setState(() {
        _nameController.clear();
        _matchesController.clear();
        _runsController.clear();
        _wicketsController.clear();
        _outsController.clear();

        if (_playersBox.length == 5) {
          _showStatsButton = true;
        } else {
          _showStatsButton = false;
        }
      });
    }
  }

  Player? _getBestPlayer() {
    Player? bestPlayer;
    double bestScore = -1;
    for (Player player in _playersBox.values) {
      double score = player.score;
      if (score > bestScore) {
        bestScore = score;
        bestPlayer = player;
      }
    }
    return bestPlayer;
  }

  Player? _getBestWicketsPlayer() {
    Player? bestWicketsPlayer;
    int highestWickets = -1;
    for (Player player in _playersBox.values) {
      if (player.wickets > highestWickets) {
        highestWickets = player.wickets;
        bestWicketsPlayer = player;
      }
    }
    return bestWicketsPlayer;
  }

  Player? _getBestAveragePlayer() {
    Player? bestAveragePlayer;
    double bestAverage = -1;
    for (Player player in _playersBox.values) {
      double average = player.battingAverage;
      if (average > bestAverage) {
        bestAverage = average;
        bestAveragePlayer = player;
      }
    }
    return bestAveragePlayer;
  }

  void _navigateToPlayerStatsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerStatsPage(
          bestPlayer: _getBestPlayer(),
          bestAveragePlayer: _getBestAveragePlayer(),
          bestWicketsPlayer: _getBestWicketsPlayer(),
        ),
      ),
    );
  }

  void _newButtonAction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerDetailsPage(players: _playersBox.values.toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Player Details',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Color(0xffec0a8e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Player Name',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter player name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _matchesController,
                decoration: InputDecoration(
                  labelText: 'Total Matches',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total matches';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _runsController,
                decoration: InputDecoration(
                  labelText: 'Total Runs',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total runs';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _wicketsController,
                decoration: InputDecoration(
                  labelText: 'Total Wickets',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total wickets';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _outsController,
                decoration: InputDecoration(
                  labelText: 'Total Outs',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total outs';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _playersBox.length < 5 ? _addPlayer : null,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(150, 60)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xffec0a8e)),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              if (_showStatsButton) ...[
                ElevatedButton(
                  onPressed: _navigateToPlayerStatsPage,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(200, 60)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffec0a8e)),
                  ),
                  child: Text(
                    'View Player Stats',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _newButtonAction,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(200, 60)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffec0a8e)),
                  ),
                  child: Text(
                    'Player Details',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
