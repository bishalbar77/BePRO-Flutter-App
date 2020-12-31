import 'package:flutter/cupertino.dart';

class Connections {
  String tutor_id;
  String student_id;
  String request_send;
  String request_accepted;
  String is_subscribed;
  String is_paid;
  String on_trail;

  Connections ({
    this.tutor_id,
    this.student_id,
    this.request_send,
    this.request_accepted,
    this.is_subscribed,
    this.is_paid,
    this.on_trail,
  });

  Map<String, dynamic> toJson() {
    return {
      "tutor_id": tutor_id,
      "student_id" : student_id
    };
  }
  factory Connections.fromJson(Map<String, dynamic> item) {
    return Connections(
        tutor_id: item['tutor_id'],
        student_id: item['student_id'],
        request_send: item['request_send'],
        request_accepted: item['request_accepted'],
        is_paid: item['is_paid'],
        on_trail: item['on_trail'],
        is_subscribed: item['is_subscribed']
    );
  }
}