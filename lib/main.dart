// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class BoardCtrl extends GetxController {
  ChessBoardController chessController = ChessBoardController();
  RxString fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'.obs; //start-fen
  final name = ''.obs;
  final x = ''.obs;

  void updateFen(String x) {
    fen.value = x;
    chessController.loadFen(x);
  }

  BoardCtrl(String nam) {
    name.value = nam;
  }
}

void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  //BoardCtrl controller = BoardCtrl();
  //ChessBoardController controller1 = ChessBoardController();
  //ChessBoardController controller2 = ChessBoardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chessboard')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetX<BoardCtrl>(
                tag: "Chess1",
                init: BoardCtrl('Chess1'),
                builder: (controller) {
                  return Column(
                    children: [
                      Text(
                        '${controller.name.value}: ${controller.x.value}',
                        style: TextStyle(fontSize: 24),
                      ),
                      ElevatedButton(
                        child: Text('Update fen'),
                        onPressed: () async {
                          final result = await Get.to(
                                () => EditFenPage(username: 'Chess1'),
                          );
                          if (result != null) {
                            Get.snackbar('Result', 'Received: $result');
                          }
                        },
                      ),
                      ChessBoard(
                        controller:controller.chessController,
                        //controller: ChessBoardController.loadFen(Get.find<BoardCtrl>(tag: "Chess1").fen.value),
                        boardColor: BoardColor.green,
                        boardOrientation: PlayerColor.white,
                        size: 300,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              GetX<BoardCtrl>(
                tag: "Chess2",
                init: BoardCtrl('Chess2'),
                builder: (controller) {
                  return Column(
                    children: [
                      Text(
                        '${controller.name.value}: ${controller.x.value}',
                        style: TextStyle(fontSize: 24),
                      ),
                      ElevatedButton(
                        child: Text('Update fen'),
                        onPressed: () async {
                          final result = await Get.to(
                                () => EditFenPage(username: 'Chess2'),
                          );
                          if (result != null) {
                            //controller.setFen('');
                            Get.snackbar('Result', 'Received: $result');
                          }
                        },
                      ),
                      // ChessBoard(
                      //   controller: controller2,
                      //   boardColor: BoardColor.green,
                      //   boardOrientation: PlayerColor.white,
                      //   size: 300,
                      // ),
                      ChessBoard(
                        controller:controller.chessController,
                        //controller: ChessBoardController.loadFen(Get.find<BoardCtrl>(tag: "Chess1").fen.value),
                        boardColor: BoardColor.green,
                        boardOrientation: PlayerColor.white,
                        size: 300,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditFenPage extends StatelessWidget {
  final String username;


  const EditFenPage({required this.username});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fen change')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.find<BoardCtrl>(tag: username).updateFen(
                    'r1bqkbnr/pppp1ppp/2n5/1B2p3/4P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 2 4');
                Get.back();
              },
              child: Text(
                  'Option 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<BoardCtrl>(tag: username).updateFen(
                    'Qn3rk1/p1p1p3/4qp1p/2pN2p1/4P1n1/1P3N2/P4PPP/R3KB1R w KQ - 1 16');
                Get.back();
              },
              child: Text(
                  'Option 2'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<BoardCtrl>(tag: username).updateFen(
                    'rnbqkbnr/1p1ppp1p/p3b3/8/3NPP2/2N5/PPP3PP/R1BQKB1R w KQkq - 0 6');
                Get.back();
              },
              child: Text(
                  'Option 3'),
            ),
          ],
        ),
      ),
    );
  }
}