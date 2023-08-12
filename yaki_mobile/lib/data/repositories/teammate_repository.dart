import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/teammate_model.dart';
import 'package:yaki/data/sources/remote/team_mate_api.dart';
import 'package:yaki/domain/entities/team_mate_entity.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';

class TeamMateRepository {
  final TeamMateApi teamMateApi;
  List<TeamMateEntity> teamMatelist;
  TeamMateEntity? teamMateEntity;

  TeamMateRepository(
    this.teamMateApi, {
    this.teamMatelist = const [],
    this.teamMateEntity,
  });

  /// Retrieves information from the TeamMate API <br>
  /// and stores the response in the modelList variable
  Future<List<TeamMateEntity>> getTeamMate(String captainId) async {
    try {
      final listHttpResponse = await teamMateApi.getTeamMate(captainId);
      final statusCode = listHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          final modelList = setTeammateModelList(listHttpResponse);

          List<TeamMateEntity> teamMatelist = <TeamMateEntity>[];

          for (var i = 0; i < modelList.length; i++) {
            final statusInCamelCase = StatusUtils.toCamelCase(
              toFormat: modelList[i].declarationStatus ?? 'undeclared',
              splitChar: ' ',
            );

            if (i != 0 && modelList[i].userId == modelList[i - 1].userId) {
              teamMatelist.last.addHalfDayDeclaration(statusInCamelCase);
            } else {
              teamMatelist.add(
                TeamMateEntity(
                  userFirstName: modelList[i].userFirstName,
                  userLastName: modelList[i].userLastName,
                  declarationDate: modelList[i].declarationDate,
                  declarationStatus: statusInCamelCase,
                ),
              );
            }
          }

          return teamMatelist;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during teammate list get : $err');
      return [];
    }
  }

  /// Function converting httpResponse.data ( a List<dynamic> of Map ) into a
  /// List<TeammateModel> using map, which create a List<dynamic> of TeammateModel.
  /// Convert it afterward into a List<TeammateModel>
  List<TeammateModel> setTeammateModelList(HttpResponse response) {
    final dynamicList = response.data.map(
      (teammate) {
        return TeammateModel.fromJson(teammate);
      },
    ).toList();
    List<TeammateModel> modelList = List<TeammateModel>.from(dynamicList);
    return modelList;
  }
}
