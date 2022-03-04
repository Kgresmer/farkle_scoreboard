import '../models/ExistingPlayer.dart';
import '../models/Player.dart';
import 'package:flutter/material.dart';

class ExistingPlayers with ChangeNotifier {
  static List<Player> staticPlayers = [
    Player(name: 'Kevin',
        color: 1,
        wins: 5,
        losses: 1,
        bestScore: 10200),
    Player(name: 'Sigrid',
        color: 2,
        wins: 1,
        losses: 5,
        bestScore: 9900),
    Player(name: 'George',
        color: 4,
        wins: 16,
        losses: 15,
        bestScore: 10900),
  ];

  Map<String, ExistingPlayer> _players = {
    staticPlayers[0].id: ExistingPlayer(player: staticPlayers[0], selected: false),
    staticPlayers[1].id: ExistingPlayer(player: staticPlayers[1], selected: false),
    staticPlayers[2].id: ExistingPlayer(player: staticPlayers[2], selected: false)
  };

  Map<String, ExistingPlayer> get players {
    return new Map<String, ExistingPlayer>.from(_players);
  }

  void addWin(String id) {
    _players[id].player.wins = _players[id].player.wins + 1;
    notifyListeners();
  }

  void addPlayer(ExistingPlayer newPlayer) {
    _players.putIfAbsent(newPlayer.player.id, () => newPlayer);
    notifyListeners();
  }
}