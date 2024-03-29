import './roster.dart';
import '../FileService.dart';
import '../models/ExistingPlayer.dart';
import '../models/Player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExistingPlayers with ChangeNotifier {
  Map<String, ExistingPlayer> _players = {};

  Map<String, ExistingPlayer> get players {
    return new Map<String, ExistingPlayer>.from(_players);
  }

  void loadPlayers(List<Player> players) {
    players.forEach((Player p) => {
      _players.putIfAbsent(p.id, () => new ExistingPlayer(player: p, selected: false))
    });
    notifyListeners();
  }

  void addWin(String id) {
    _players[id].player.wins = _players[id].player.wins + 1;
    notifyListeners();
  }

  void removePlayer(ExistingPlayer player, [BuildContext context]) {
    _players.remove(player.player.id);
    Provider.of<Roster>(context, listen: false).removePlayer(player.player);
    FileService.writePlayerContent([..._players.values.map((e) => e.player)]);
    notifyListeners();
  }

  void addPlayer(ExistingPlayer newPlayer) {
    _players.putIfAbsent(newPlayer.player.id, () => newPlayer);
    notifyListeners();
  }
}