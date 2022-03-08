import '../models/ExistingPlayer.dart';
import '../models/Player.dart';
import 'package:flutter/material.dart';

class ExistingPlayers with ChangeNotifier {
  Map<String, ExistingPlayer> _players = {};

  Map<String, ExistingPlayer> get players {
    print('get players');
    return new Map<String, ExistingPlayer>.from(_players);
  }

  void loadPlayers(List<Player> players) {
    print('load players');
    players.forEach((Player p) => {
      _players.putIfAbsent(p.id, () => new ExistingPlayer(player: p, selected: false))
    });
    notifyListeners();
  }

  void addWin(String id) {
    print('add win');
    _players[id].player.wins = _players[id].player.wins + 1;
    notifyListeners();
  }

  void removePlayer(ExistingPlayer player) {
    print('remove player');
    _players.remove(player.player.id);
    notifyListeners();
  }

  void addPlayer(ExistingPlayer newPlayer) {
    print('add player');
    _players.putIfAbsent(newPlayer.player.id, () => newPlayer);
    notifyListeners();
  }
}