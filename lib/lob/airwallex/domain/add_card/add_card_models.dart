import 'package:network_module/data/responses/responses.dart';

class RFIResponse extends BaseResponse{

  RFIResponse.error(error) : super.error(error);

  List<QuestionList>? questionList;
  List<RequiredDocList>? requiredDocList;

  RFIResponse({this.questionList, this.requiredDocList});

  RFIResponse.fromJson(dynamic json) {
    if (json['question_list'] != null) {
      questionList = <QuestionList>[];
      json['question_list'].forEach((v) {
        questionList!.add(new QuestionList.fromJson(v));
      });
    }
    if (json['required_doc_list'] != null) {
      requiredDocList = <RequiredDocList>[];
      json['required_doc_list'].forEach((v) {
        requiredDocList!.add(new RequiredDocList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.questionList != null) {
      data['question_list'] =
          this.questionList!.map((v) => v.toJson()).toList();
    }
    if (this.requiredDocList != null) {
      data['required_doc_list'] =
          this.requiredDocList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionList {
  String? question;
  String? questionHint;
  String? questionDesc;
  String? questionAnswer;

  QuestionList(
      {this.question,
        this.questionHint,
        this.questionDesc,
        this.questionAnswer});

  QuestionList.fromJson(dynamic json) {
    question = json['question'];
    questionHint = json['question_hint'];
    questionDesc = json['question_desc'];
    questionAnswer = json['question_answer'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['question'] = this.question;
    data['question_hint'] = this.questionHint;
    data['question_desc'] = this.questionDesc;
    data['question_answer'] = this.questionAnswer;
    return data;
  }
}

class RequiredDocList {
  String? title;
  bool? upload;

  RequiredDocList({this.title, this.upload});

  RequiredDocList.fromJson(dynamic json) {
    title = json['title'];
    upload = json['upload'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = this.title;
    data['upload'] = this.upload;
    return data;
  }
}


