import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iplanalysis_hive_database/player.dart';

class PlayerDetailsPage extends StatefulWidget {
  final List<Player> players;

  PlayerDetailsPage({required this.players});

  @override
  _PlayerDetailsPageState createState() => _PlayerDetailsPageState();
}

class _PlayerDetailsPageState extends State<PlayerDetailsPage> {
  // Controllers for each player attribute
  late List<TextEditingController> _nameControllers;
  late List<TextEditingController> _matchesControllers;
  late List<TextEditingController> _runsControllers;
  late List<TextEditingController> _wicketsControllers;
  late List<TextEditingController> _outsControllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with player data
    _nameControllers = widget.players
        .map((player) => TextEditingController(text: player.name))
        .toList();
    _matchesControllers = widget.players
        .map((player) => TextEditingController(text: player.matches.toString()))
        .toList();
    _runsControllers = widget.players
        .map((player) => TextEditingController(text: player.runs.toString()))
        .toList();
    _wicketsControllers = widget.players
        .map((player) => TextEditingController(text: player.wickets.toString()))
        .toList();
    _outsControllers = widget.players
        .map((player) => TextEditingController(text: player.outs.toString()))
        .toList();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _nameControllers.forEach((controller) => controller.dispose());
    _matchesControllers.forEach((controller) => controller.dispose());
    _runsControllers.forEach((controller) => controller.dispose());
    _wicketsControllers.forEach((controller) => controller.dispose());
    _outsControllers.forEach((controller) => controller.dispose());
  }

  void _saveChanges() {
    // Save changes from controllers back to the player objects
    for (int i = 0; i < widget.players.length; i++) {
      widget.players[i].name = _nameControllers[i].text;
      widget.players[i].matches = int.parse(_matchesControllers[i].text);
      widget.players[i].runs = int.parse(_runsControllers[i].text);
      widget.players[i].wickets = int.parse(_wicketsControllers[i].text);
      widget.players[i].outs = int.parse(_outsControllers[i].text);
    }

    // Save updated players list to Hive database
    Hive.box<Player>('playersBox').putAll(widget.players.asMap());

    Navigator.pop(context);
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
        child: ListView.builder(
          itemCount: widget.players.length,
          itemBuilder: (context, index) {
            Player player = widget.players[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Build editable fields for each player attribute
                    _buildEditableField(
                      controller: _nameControllers[index],
                      label: 'Player Name',
                      onChanged: (value) {
                        setState(() {
                          player.name = value;
                        });
                      },
                    ),
                    _buildEditableField(
                      controller: _matchesControllers[index],
                      label: 'Total Matches',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          player.matches = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    _buildEditableField(
                      controller: _runsControllers[index],
                      label: 'Total Runs',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          player.runs = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    _buildEditableField(
                      controller: _wicketsControllers[index],
                      label: 'Total Wickets',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          player.wickets = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    _buildEditableField(
                      controller: _outsControllers[index],
                      label: 'Total Outs',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          player.outs = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // Display calculated attributes
                    Text(
                      'Batting Average: ${player.battingAverage.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Score: ${player.score.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to build editable fields
  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 20),
      ),
      style: TextStyle(fontSize: 24),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
