/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the GuruModel type in your schema. */
class GuruModel extends amplify_core.Model {
  static const classType = const _GuruModelModelType();
  final String id;
  final String? _documentId;
  final String? _username;
  final String? _about;
  final bool? _isOnline;
  final String? _phoneNumber;
  final double? _totalRating;
  final String? _qualification;
  final int? _yearOfExperience;
  final String? _experience;
  final String? _imageUrl;
  final String? _specialist;
  final String? _joiningTime;
  final String? _unAvailableFrom;
  final String? _unAvailableTo;
  final String? _timeFrom;
  final String? _timeTo;
  final String? _pushToken;
  final FeesCharge? _feesCharge;
  final List<String>? _listExplore;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  GuruModelModelIdentifier get modelIdentifier {
      return GuruModelModelIdentifier(
        id: id
      );
  }
  
  String? get documentId {
    return _documentId;
  }
  
  String? get username {
    return _username;
  }
  
  String? get about {
    return _about;
  }
  
  bool? get isOnline {
    return _isOnline;
  }
  
  String? get phoneNumber {
    return _phoneNumber;
  }
  
  double? get totalRating {
    return _totalRating;
  }
  
  String? get qualification {
    return _qualification;
  }
  
  int? get yearOfExperience {
    return _yearOfExperience;
  }
  
  String? get experience {
    return _experience;
  }
  
  String? get imageUrl {
    return _imageUrl;
  }
  
  String? get specialist {
    return _specialist;
  }
  
  String? get joiningTime {
    return _joiningTime;
  }
  
  String? get unAvailableFrom {
    return _unAvailableFrom;
  }
  
  String? get unAvailableTo {
    return _unAvailableTo;
  }
  
  String? get timeFrom {
    return _timeFrom;
  }
  
  String? get timeTo {
    return _timeTo;
  }
  
  String? get pushToken {
    return _pushToken;
  }
  
  FeesCharge? get feesCharge {
    return _feesCharge;
  }
  
  List<String>? get listExplore {
    return _listExplore;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const GuruModel._internal({required this.id, documentId, username, about, isOnline, phoneNumber, totalRating, qualification, yearOfExperience, experience, imageUrl, specialist, joiningTime, unAvailableFrom, unAvailableTo, timeFrom, timeTo, pushToken, feesCharge, listExplore, createdAt, updatedAt}): _documentId = documentId, _username = username, _about = about, _isOnline = isOnline, _phoneNumber = phoneNumber, _totalRating = totalRating, _qualification = qualification, _yearOfExperience = yearOfExperience, _experience = experience, _imageUrl = imageUrl, _specialist = specialist, _joiningTime = joiningTime, _unAvailableFrom = unAvailableFrom, _unAvailableTo = unAvailableTo, _timeFrom = timeFrom, _timeTo = timeTo, _pushToken = pushToken, _feesCharge = feesCharge, _listExplore = listExplore, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory GuruModel({String? id, String? documentId, String? username, String? about, bool? isOnline, String? phoneNumber, double? totalRating, String? qualification, int? yearOfExperience, String? experience, String? imageUrl, String? specialist, String? joiningTime, String? unAvailableFrom, String? unAvailableTo, String? timeFrom, String? timeTo, String? pushToken, FeesCharge? feesCharge, List<String>? listExplore}) {
    return GuruModel._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      documentId: documentId,
      username: username,
      about: about,
      isOnline: isOnline,
      phoneNumber: phoneNumber,
      totalRating: totalRating,
      qualification: qualification,
      yearOfExperience: yearOfExperience,
      experience: experience,
      imageUrl: imageUrl,
      specialist: specialist,
      joiningTime: joiningTime,
      unAvailableFrom: unAvailableFrom,
      unAvailableTo: unAvailableTo,
      timeFrom: timeFrom,
      timeTo: timeTo,
      pushToken: pushToken,
      feesCharge: feesCharge,
      listExplore: listExplore != null ? List<String>.unmodifiable(listExplore) : listExplore);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GuruModel &&
      id == other.id &&
      _documentId == other._documentId &&
      _username == other._username &&
      _about == other._about &&
      _isOnline == other._isOnline &&
      _phoneNumber == other._phoneNumber &&
      _totalRating == other._totalRating &&
      _qualification == other._qualification &&
      _yearOfExperience == other._yearOfExperience &&
      _experience == other._experience &&
      _imageUrl == other._imageUrl &&
      _specialist == other._specialist &&
      _joiningTime == other._joiningTime &&
      _unAvailableFrom == other._unAvailableFrom &&
      _unAvailableTo == other._unAvailableTo &&
      _timeFrom == other._timeFrom &&
      _timeTo == other._timeTo &&
      _pushToken == other._pushToken &&
      _feesCharge == other._feesCharge &&
      DeepCollectionEquality().equals(_listExplore, other._listExplore);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("GuruModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("documentId=" + "$_documentId" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("about=" + "$_about" + ", ");
    buffer.write("isOnline=" + (_isOnline != null ? _isOnline!.toString() : "null") + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("totalRating=" + (_totalRating != null ? _totalRating!.toString() : "null") + ", ");
    buffer.write("qualification=" + "$_qualification" + ", ");
    buffer.write("yearOfExperience=" + (_yearOfExperience != null ? _yearOfExperience!.toString() : "null") + ", ");
    buffer.write("experience=" + "$_experience" + ", ");
    buffer.write("imageUrl=" + "$_imageUrl" + ", ");
    buffer.write("specialist=" + "$_specialist" + ", ");
    buffer.write("joiningTime=" + "$_joiningTime" + ", ");
    buffer.write("unAvailableFrom=" + "$_unAvailableFrom" + ", ");
    buffer.write("unAvailableTo=" + "$_unAvailableTo" + ", ");
    buffer.write("timeFrom=" + "$_timeFrom" + ", ");
    buffer.write("timeTo=" + "$_timeTo" + ", ");
    buffer.write("pushToken=" + "$_pushToken" + ", ");
    buffer.write("feesCharge=" + (_feesCharge != null ? _feesCharge!.toString() : "null") + ", ");
    buffer.write("listExplore=" + (_listExplore != null ? _listExplore!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  GuruModel copyWith({String? documentId, String? username, String? about, bool? isOnline, String? phoneNumber, double? totalRating, String? qualification, int? yearOfExperience, String? experience, String? imageUrl, String? specialist, String? joiningTime, String? unAvailableFrom, String? unAvailableTo, String? timeFrom, String? timeTo, String? pushToken, FeesCharge? feesCharge, List<String>? listExplore}) {
    return GuruModel._internal(
      id: id,
      documentId: documentId ?? this.documentId,
      username: username ?? this.username,
      about: about ?? this.about,
      isOnline: isOnline ?? this.isOnline,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      totalRating: totalRating ?? this.totalRating,
      qualification: qualification ?? this.qualification,
      yearOfExperience: yearOfExperience ?? this.yearOfExperience,
      experience: experience ?? this.experience,
      imageUrl: imageUrl ?? this.imageUrl,
      specialist: specialist ?? this.specialist,
      joiningTime: joiningTime ?? this.joiningTime,
      unAvailableFrom: unAvailableFrom ?? this.unAvailableFrom,
      unAvailableTo: unAvailableTo ?? this.unAvailableTo,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      pushToken: pushToken ?? this.pushToken,
      feesCharge: feesCharge ?? this.feesCharge,
      listExplore: listExplore ?? this.listExplore);
  }
  
  GuruModel copyWithModelFieldValues({
    ModelFieldValue<String?>? documentId,
    ModelFieldValue<String?>? username,
    ModelFieldValue<String?>? about,
    ModelFieldValue<bool?>? isOnline,
    ModelFieldValue<String?>? phoneNumber,
    ModelFieldValue<double?>? totalRating,
    ModelFieldValue<String?>? qualification,
    ModelFieldValue<int?>? yearOfExperience,
    ModelFieldValue<String?>? experience,
    ModelFieldValue<String?>? imageUrl,
    ModelFieldValue<String?>? specialist,
    ModelFieldValue<String?>? joiningTime,
    ModelFieldValue<String?>? unAvailableFrom,
    ModelFieldValue<String?>? unAvailableTo,
    ModelFieldValue<String?>? timeFrom,
    ModelFieldValue<String?>? timeTo,
    ModelFieldValue<String?>? pushToken,
    ModelFieldValue<FeesCharge?>? feesCharge,
    ModelFieldValue<List<String>?>? listExplore
  }) {
    return GuruModel._internal(
      id: id,
      documentId: documentId == null ? this.documentId : documentId.value,
      username: username == null ? this.username : username.value,
      about: about == null ? this.about : about.value,
      isOnline: isOnline == null ? this.isOnline : isOnline.value,
      phoneNumber: phoneNumber == null ? this.phoneNumber : phoneNumber.value,
      totalRating: totalRating == null ? this.totalRating : totalRating.value,
      qualification: qualification == null ? this.qualification : qualification.value,
      yearOfExperience: yearOfExperience == null ? this.yearOfExperience : yearOfExperience.value,
      experience: experience == null ? this.experience : experience.value,
      imageUrl: imageUrl == null ? this.imageUrl : imageUrl.value,
      specialist: specialist == null ? this.specialist : specialist.value,
      joiningTime: joiningTime == null ? this.joiningTime : joiningTime.value,
      unAvailableFrom: unAvailableFrom == null ? this.unAvailableFrom : unAvailableFrom.value,
      unAvailableTo: unAvailableTo == null ? this.unAvailableTo : unAvailableTo.value,
      timeFrom: timeFrom == null ? this.timeFrom : timeFrom.value,
      timeTo: timeTo == null ? this.timeTo : timeTo.value,
      pushToken: pushToken == null ? this.pushToken : pushToken.value,
      feesCharge: feesCharge == null ? this.feesCharge : feesCharge.value,
      listExplore: listExplore == null ? this.listExplore : listExplore.value
    );
  }
  
  GuruModel.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _documentId = json['documentId'],
      _username = json['username'],
      _about = json['about'],
      _isOnline = json['isOnline'],
      _phoneNumber = json['phoneNumber'],
      _totalRating = (json['totalRating'] as num?)?.toDouble(),
      _qualification = json['qualification'],
      _yearOfExperience = (json['yearOfExperience'] as num?)?.toInt(),
      _experience = json['experience'],
      _imageUrl = json['imageUrl'],
      _specialist = json['specialist'],
      _joiningTime = json['joiningTime'],
      _unAvailableFrom = json['unAvailableFrom'],
      _unAvailableTo = json['unAvailableTo'],
      _timeFrom = json['timeFrom'],
      _timeTo = json['timeTo'],
      _pushToken = json['pushToken'],
      _feesCharge = json['feesCharge']?['serializedData'] != null
        ? FeesCharge.fromJson(new Map<String, dynamic>.from(json['feesCharge']['serializedData']))
        : null,
      _listExplore = json['listExplore']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'documentId': _documentId, 'username': _username, 'about': _about, 'isOnline': _isOnline, 'phoneNumber': _phoneNumber, 'totalRating': _totalRating, 'qualification': _qualification, 'yearOfExperience': _yearOfExperience, 'experience': _experience, 'imageUrl': _imageUrl, 'specialist': _specialist, 'joiningTime': _joiningTime, 'unAvailableFrom': _unAvailableFrom, 'unAvailableTo': _unAvailableTo, 'timeFrom': _timeFrom, 'timeTo': _timeTo, 'pushToken': _pushToken, 'feesCharge': _feesCharge?.toJson(), 'listExplore': _listExplore, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'documentId': _documentId,
    'username': _username,
    'about': _about,
    'isOnline': _isOnline,
    'phoneNumber': _phoneNumber,
    'totalRating': _totalRating,
    'qualification': _qualification,
    'yearOfExperience': _yearOfExperience,
    'experience': _experience,
    'imageUrl': _imageUrl,
    'specialist': _specialist,
    'joiningTime': _joiningTime,
    'unAvailableFrom': _unAvailableFrom,
    'unAvailableTo': _unAvailableTo,
    'timeFrom': _timeFrom,
    'timeTo': _timeTo,
    'pushToken': _pushToken,
    'feesCharge': _feesCharge,
    'listExplore': _listExplore,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<GuruModelModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<GuruModelModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final DOCUMENTID = amplify_core.QueryField(fieldName: "documentId");
  static final USERNAME = amplify_core.QueryField(fieldName: "username");
  static final ABOUT = amplify_core.QueryField(fieldName: "about");
  static final ISONLINE = amplify_core.QueryField(fieldName: "isOnline");
  static final PHONENUMBER = amplify_core.QueryField(fieldName: "phoneNumber");
  static final TOTALRATING = amplify_core.QueryField(fieldName: "totalRating");
  static final QUALIFICATION = amplify_core.QueryField(fieldName: "qualification");
  static final YEAROFEXPERIENCE = amplify_core.QueryField(fieldName: "yearOfExperience");
  static final EXPERIENCE = amplify_core.QueryField(fieldName: "experience");
  static final IMAGEURL = amplify_core.QueryField(fieldName: "imageUrl");
  static final SPECIALIST = amplify_core.QueryField(fieldName: "specialist");
  static final JOININGTIME = amplify_core.QueryField(fieldName: "joiningTime");
  static final UNAVAILABLEFROM = amplify_core.QueryField(fieldName: "unAvailableFrom");
  static final UNAVAILABLETO = amplify_core.QueryField(fieldName: "unAvailableTo");
  static final TIMEFROM = amplify_core.QueryField(fieldName: "timeFrom");
  static final TIMETO = amplify_core.QueryField(fieldName: "timeTo");
  static final PUSHTOKEN = amplify_core.QueryField(fieldName: "pushToken");
  static final FEESCHARGE = amplify_core.QueryField(fieldName: "feesCharge");
  static final LISTEXPLORE = amplify_core.QueryField(fieldName: "listExplore");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "GuruModel";
    modelSchemaDefinition.pluralName = "GuruModels";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.DOCUMENTID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.USERNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.ABOUT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.ISONLINE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.PHONENUMBER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.TOTALRATING,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.QUALIFICATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.YEAROFEXPERIENCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.EXPERIENCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.IMAGEURL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.SPECIALIST,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.JOININGTIME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.UNAVAILABLEFROM,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.UNAVAILABLETO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.TIMEFROM,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.TIMETO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.PUSHTOKEN,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'feesCharge',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'FeesCharge')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: GuruModel.LISTEXPLORE,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _GuruModelModelType extends amplify_core.ModelType<GuruModel> {
  const _GuruModelModelType();
  
  @override
  GuruModel fromJson(Map<String, dynamic> jsonData) {
    return GuruModel.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'GuruModel';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [GuruModel] in your schema.
 */
class GuruModelModelIdentifier implements amplify_core.ModelIdentifier<GuruModel> {
  final String id;

  /** Create an instance of GuruModelModelIdentifier using [id] the primary key. */
  const GuruModelModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'GuruModelModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is GuruModelModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}