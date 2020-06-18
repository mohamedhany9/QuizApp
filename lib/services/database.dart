import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServices {
  Future<void> addQuizData(Map quizdata, quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .setData(quizdata)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questiondata, quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .add(questiondata)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData() async {
    return await Firestore.instance.collection("Quiz").snapshots();
  }

  getQuizuzData(String quizId) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

}
