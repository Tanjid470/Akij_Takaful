import 'dart:convert';

import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/policy/proposal_List_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final authController = Get.find<AuthController>();

List<ProposalListModel> parsedProposal(String body) {
  var list = json.decode(body) as List<dynamic>;

  List<ProposalListModel> proposals =
      list.map((item) => ProposalListModel.fromJson(item)).toList();

  return proposals;
}

Future<List<ProposalListModel>> callForProposalList() async {
  var response = await http.post(
      Uri.parse('${authController.baseUrl}v1/Apps/ProposalList'),
      headers: {'token': authController.getToken()},
      body: {'userName': authController.getPolicyNo()});

  var statusCode = json.decode(response.body)[0]['errCode'];

  if (statusCode == "0") {
    var data = json.decode(response.body)[0]['response'];

    ProposalListModel infoContent = ProposalListModel.fromJson(data);
    print(data);
    return parsedProposal(data);
  } else {
    throw Exception("Error");
  }
}
