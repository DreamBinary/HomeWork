import 'dart:convert';

import 'package:db_show/entity/Goal.dart';
import 'package:db_show/entity/goal_record.dart';
import 'package:db_show/net/url.dart';

import '../entity/book.dart';
import '../entity/book_record.dart';
import 'dio.dart';

class Api {
  static Future<Map<String, List<Book>>?> getBook(String username) async {
    var response =
        await DioUtil().get(Url.getBook, map: {"username": username});
    if (response?.data["code"] == 200) {
      var data = response?.data["data"];
      var result = <String, List<Book>>{};
      data.forEach((key, value) {
        result[key] = List<Book>.from(value.map((e) => Book.fromJson(e)));
      });
      return result;
    }
    return null;
  }

  static Future<bool?> addBook(
      String name, String author, String description) async {
    var response = await DioUtil().postForm(
        Url.addBook,
        {
          "name": name,
          "author": author,
          "description": description,
        },
        null);
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  // delete
  static Future<bool?> deleteBook(num bookId) async {
    var response =
        await DioUtil().deleteForm(Url.deleteBook, {"book_id": bookId});
    if (response?.data["code"] == 200) {
      print(response?.data["msg"]);
      return true;
    }
    return false;
  }

  // update
  static Future<bool?> updateBook(
      num bookId, String name, String description) async {
    var response = await DioUtil().putForm(Url.updateBook, {
      "book_id": bookId,
      "name": name,
      "description": description,
    });
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<List<BookRecord>?> getRecord(num bookId) async {
    var response = await DioUtil().get(Url.getRecord, map: {"book_id": bookId});
    if (response?.data["code"] == 200) {
      var data = response?.data["data"];
      var result =
          List<BookRecord>.from(data.map((e) => BookRecord.fromJson(e)));

      return result;
    }
    return null;
  }

  //delete
  static Future<bool?> deleteRecord(num recordId) async {
    var response =
        await DioUtil().deleteForm(Url.deleteRecord, {"record_id": recordId});
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  //update
  static Future<bool?> updateRecord(
      num recordId, String name, String typeName, num price, bool isIn) async {
    var response = await DioUtil().putForm(Url.updateRecord, {
      "record_id": recordId,
      "name": name,
      "type_name": typeName,
      "price": price,
      "is_in": isIn,
    });
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<bool?> addRecord(
      num bookId, String name, String typeName, num price, bool isIn) async {
    var response = await DioUtil().postForm(
        Url.addRecord,
        {
          "book_id": bookId,
          "name": name,
          "type_name": typeName,
          "price": price,
          "is_in": isIn,
        },
        null);
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<List<Goal>?> getGoal(String username) async {
    var response =
        await DioUtil().get(Url.getGoal, map: {"username": username});
    if (response?.data["code"] == 200) {
      var data = response?.data["data"];
      var result = List<Goal>.from(data.map((e) => Goal.fromJson(e)));
      return result;
    }
    return null;
  }

  static Future<bool?> addGoal(
      String name, String description, num goalMoney) async {
    var response = await DioUtil().postForm(
        Url.addGoal,
        {
          "name": name,
          "description": description,
          "goal_money": goalMoney,
        },
        null);
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<bool?> deleteGoal(num goalId) async {
    var response =
        await DioUtil().deleteForm(Url.deleteGoal, {"goal_id": goalId});
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<bool?> updateGoal(
      num goalId, String name, String description, num goalMoney) async {
    var response = await DioUtil().putForm(Url.updateGoal, {
      "goal_id": goalId,
      "name": name,
      "description": description,
      "goal_money": goalMoney,
    });
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<List<GoalRecord>?> getGoalRecord(num goalId) async {
    var response =
        await DioUtil().get(Url.getGoalRecord, map: {"goal_id": goalId});
    if (response?.data["code"] == 200) {
      var data = response?.data["data"];
      var result =
          List<GoalRecord>.from(data.map((e) => GoalRecord.fromJson(e)));
      return result;
    }
    return null;
  }

  static Future<bool?> addGoalRecord(num goalId, num money) async {
    var response = await DioUtil().postForm(
        Url.addGoalRecord,
        {
          "goal_id": goalId,
          "money": money,
        },
        null);
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<bool?> deleteGoalRecord(num goalRecordId) async {
    var response = await DioUtil()
        .deleteForm(Url.deleteGoalRecord, {"goal_record_id": goalRecordId});
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<bool?> updateGoalRecord(num goalRecordId, num money) async {
    var response = await DioUtil().putForm(Url.updateGoalRecord, {
      "goal_record_id": goalRecordId,
      "money": money,
    });
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }
}
