import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

//controller class which has a ChessBoardController in it, fen and a name
class BoardCtrl extends GetxController {
  ChessBoardController chessController = ChessBoardController();
  RxString fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'.obs; //start fen
  final name = ''.obs;

  void updateFen(String x) {
    fen.value = x;
    chessController.loadFen(x);
  }

  BoardCtrl(String nam) {
    name.value = nam;
  }
}

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chessboard')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetX<BoardCtrl>(      //controller called
                tag: "Chess1",
                init: BoardCtrl('Chess1'),
                builder: (controller) {
                  return Column(
                    children: [
                      Card(
                        color: Colors.cyan,
                        child: SizedBox(
                          width:300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${controller.name.value}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,letterSpacing: 2.0,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan,),
                            child: const Text('Update fen'),
                            onPressed: () async {
                              final result = await Get.to(
                                    () => const EditFenPage(username: 'Chess1'),
                              );
                              if (result != null) {
                                Get.snackbar('Result', 'Received: $result');
                              }
                            },
                          ),
                        ),
                      ),
                      ChessBoard(      //chessboard widget
                        controller:controller.chessController,
                        boardColor: BoardColor.green,
                        boardOrientation: PlayerColor.white,
                        size: 300,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              GetX<BoardCtrl>(     //second controller called
                tag: "Chess2",
                init: BoardCtrl('Chess2'),
                builder: (controller) {
                  return Column(
                    children: [
                      Card(
                        color: Colors.brown,
                        child: SizedBox(
                          width:300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${controller.name.value}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,letterSpacing: 2.0,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.brown,),
                            child: const Text('Update fen'),
                            onPressed: () async {
                              final result = await Get.to(
                                    () => const EditFenPage(username: 'Chess2'),
                              );
                              if (result != null) {
                                Get.snackbar('Result', 'Received: $result');
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ChessBoard(        //chessboard widget
                          controller:controller.chessController,
                          boardColor: BoardColor.brown,
                          boardOrientation: PlayerColor.white,
                          size: 300,
                        ),
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

//second page
class EditFenPage extends StatelessWidget {
  final String username;

  const EditFenPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fen change')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Card(
              color: Colors.blue,
              child: SizedBox(
                width:300,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Avaiable fen options:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        letterSpacing: 2.0,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<BoardCtrl>(tag: username).updateFen(
                        'r1bqkbnr/pppp1ppp/2n5/1B2p3/4P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 2 4');
                    Get.back();
                  },
                  child: const Text(
                      'Option 1',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<BoardCtrl>(tag: username).updateFen(
                        'Qn3rk1/p1p1p3/4qp1p/2pN2p1/4P1n1/1P3N2/P4PPP/R3KB1R w KQ - 1 16');
                    Get.back();
                  },
                  child: const Text(
                      'Option 2',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<BoardCtrl>(tag: username).updateFen(
                        'rnbqkbnr/1p1ppp1p/p3b3/8/3NPP2/2N5/PPP3PP/R1BQKB1R w KQkq - 0 6');
                    Get.back();
                  },
                  child: const Text(
                      'Option 3',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}