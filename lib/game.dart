import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/alert_dialog.dart';
import 'package:tic_tac_toe/game_button.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<GameButton> buttonList;
  var player1, player2, activePlayer;

  @override
  void initState() {
    super.initState();
    buttonList = initializeGame();
  }

  List<GameButton> initializeGame() {
    player1 = List();
    player2 = List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];

    return gameButtons;
  }

  void playGame(GameButton gB) {
    setState(
          () {
        if (activePlayer == 1) {
          gB.text = 'X';
          gB.bgColor = Colors.redAccent;
          activePlayer = 2;
          player1.add(gB.id);
        } else {
          gB.text = 'O';
          gB.bgColor = Colors.lightBlue;
          activePlayer = 1;
          player2.add(gB.id);
        }
        gB.enabled = false;
        int winner = checkForWinner();
        if (winner == -1) {
          if (buttonList.every((test) => test.text != "")) {
            showDialog(
              context: context,
              builder: (_) =>
                  CustomAlertDialog("Game Tied",
                      "Press the reset button to play again", resetGame),
            );
          } else {
            activePlayer == 2 ? autoPlay() : null;
          }
        }
      },
    );
  }

  int checkForWinner() {
    var winner = -1;
    // row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) =>
            new CustomAlertDialog("You Won",
                "Press the reset button to start again.", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) =>
            new CustomAlertDialog("Mobile Won",
                "Press the reset button to start again.", resetGame));
      }
    }
    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = initializeGame();
    });
  }

  void autoPlay() {
    //played by Random
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonList.indexWhere((p) => p.id == cellID);
    playGame(buttonList[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 100),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: buttonList.length,
              itemBuilder: (context, i) =>
                  SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      onPressed: buttonList[i].enabled
                          ? () => playGame(buttonList[i])
                          : null,
                      child: Text(
                        buttonList[i].text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      color: buttonList[i].bgColor,
                      disabledColor: buttonList[i].bgColor,
                    ),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 100, left: 50, right: 50),
            child: FloatingActionButton(
              onPressed: resetGame,
              backgroundColor: Colors.cyan[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Reset"),
            ),
          )
        ],
      ),
    );
  }
}
