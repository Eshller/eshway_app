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


/** This is an auto generated class representing the CallModel type in your schema. */
class CallModel extends amplify_core.Model {
  static const classType = const _CallModelModelType();
  final String id;
  final String? _callerId;
  final String? _callerName;
  final String? _receiverId;
  final String? _receiverPic;
  final String? _callId;
  final bool? _hasDialled;
  final bool? _isVoiceCall;
  final String? _timestamp;
  final String? _pushToken;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CallModelModelIdentifier get modelIdentifier {
      return CallModelModelIdentifier(
        id: id
      );
  }
  
  String? get callerId {
    return _callerId;
  }
  
  String? get callerName {
    return _callerName;
  }
  
  String? get receiverId {
    return _receiverId;
  }
  
  String? get receiverPic {
    return _receiverPic;
  }
  
  String? get callId {
    return _callId;
  }
  
  bool? get hasDialled {
    return _hasDialled;
  }
  
  bool? get isVoiceCall {
    return _isVoiceCall;
  }
  
  String? get timestamp {
    return _timestamp;
  }
  
  String? get pushToken {
    return _pushToken;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const CallModel._internal({required this.id, callerId, callerName, receiverId, receiverPic, callId, hasDialled, isVoiceCall, timestamp, pushToken, createdAt, updatedAt}): _callerId = callerId, _callerName = callerName, _receiverId = receiverId, _receiverPic = receiverPic, _callId = callId, _hasDialled = hasDialled, _isVoiceCall = isVoiceCall, _timestamp = timestamp, _pushToken = pushToken, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory CallModel({String? id, String? callerId, String? callerName, String? receiverId, String? receiverPic, String? callId, bool? hasDialled, bool? isVoiceCall, String? timestamp, String? pushToken}) {
    return CallModel._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      callerId: callerId,
      callerName: callerName,
      receiverId: receiverId,
      receiverPic: receiverPic,
      callId: callId,
      hasDialled: hasDialled,
      isVoiceCall: isVoiceCall,
      timestamp: timestamp,
      pushToken: pushToken);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CallModel &&
      id == other.id &&
      _callerId == other._callerId &&
      _callerName == other._callerName &&
      _receiverId == other._receiverId &&
      _receiverPic == other._receiverPic &&
      _callId == other._callId &&
      _hasDialled == other._hasDialled &&
      _isVoiceCall == other._isVoiceCall &&
      _timestamp == other._timestamp &&
      _pushToken == other._pushToken;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CallModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("callerId=" + "$_callerId" + ", ");
    buffer.write("callerName=" + "$_callerName" + ", ");
    buffer.write("receiverId=" + "$_receiverId" + ", ");
    buffer.write("receiverPic=" + "$_receiverPic" + ", ");
    buffer.write("callId=" + "$_callId" + ", ");
    buffer.write("hasDialled=" + (_hasDialled != null ? _hasDialled!.toString() : "null") + ", ");
    buffer.write("isVoiceCall=" + (_isVoiceCall != null ? _isVoiceCall!.toString() : "null") + ", ");
    buffer.write("timestamp=" + "$_timestamp" + ", ");
    buffer.write("pushToken=" + "$_pushToken" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CallModel copyWith({String? callerId, String? callerName, String? receiverId, String? receiverPic, String? callId, bool? hasDialled, bool? isVoiceCall, String? timestamp, String? pushToken}) {
    return CallModel._internal(
      id: id,
      callerId: callerId ?? this.callerId,
      callerName: callerName ?? this.callerName,
      receiverId: receiverId ?? this.receiverId,
      receiverPic: receiverPic ?? this.receiverPic,
      callId: callId ?? this.callId,
      hasDialled: hasDialled ?? this.hasDialled,
      isVoiceCall: isVoiceCall ?? this.isVoiceCall,
      timestamp: timestamp ?? this.timestamp,
      pushToken: pushToken ?? this.pushToken);
  }
  
  CallModel copyWithModelFieldValues({
    ModelFieldValue<String?>? callerId,
    ModelFieldValue<String?>? callerName,
    ModelFieldValue<String?>? receiverId,
    ModelFieldValue<String?>? receiverPic,
    ModelFieldValue<String?>? callId,
    ModelFieldValue<bool?>? hasDialled,
    ModelFieldValue<bool?>? isVoiceCall,
    ModelFieldValue<String?>? timestamp,
    ModelFieldValue<String?>? pushToken
  }) {
    return CallModel._internal(
      id: id,
      callerId: callerId == null ? this.callerId : callerId.value,
      callerName: callerName == null ? this.callerName : callerName.value,
      receiverId: receiverId == null ? this.receiverId : receiverId.value,
      receiverPic: receiverPic == null ? this.receiverPic : receiverPic.value,
      callId: callId == null ? this.callId : callId.value,
      hasDialled: hasDialled == null ? this.hasDialled : hasDialled.value,
      isVoiceCall: isVoiceCall == null ? this.isVoiceCall : isVoiceCall.value,
      timestamp: timestamp == null ? this.timestamp : timestamp.value,
      pushToken: pushToken == null ? this.pushToken : pushToken.value
    );
  }
  
  CallModel.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _callerId = json['callerId'],
      _callerName = json['callerName'],
      _receiverId = json['receiverId'],
      _receiverPic = json['receiverPic'],
      _callId = json['callId'],
      _hasDialled = json['hasDialled'],
      _isVoiceCall = json['isVoiceCall'],
      _timestamp = json['timestamp'],
      _pushToken = json['pushToken'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'callerId': _callerId, 'callerName': _callerName, 'receiverId': _receiverId, 'receiverPic': _receiverPic, 'callId': _callId, 'hasDialled': _hasDialled, 'isVoiceCall': _isVoiceCall, 'timestamp': _timestamp, 'pushToken': _pushToken, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'callerId': _callerId,
    'callerName': _callerName,
    'receiverId': _receiverId,
    'receiverPic': _receiverPic,
    'callId': _callId,
    'hasDialled': _hasDialled,
    'isVoiceCall': _isVoiceCall,
    'timestamp': _timestamp,
    'pushToken': _pushToken,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<CallModelModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CallModelModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final CALLERID = amplify_core.QueryField(fieldName: "callerId");
  static final CALLERNAME = amplify_core.QueryField(fieldName: "callerName");
  static final RECEIVERID = amplify_core.QueryField(fieldName: "receiverId");
  static final RECEIVERPIC = amplify_core.QueryField(fieldName: "receiverPic");
  static final CALLID = amplify_core.QueryField(fieldName: "callId");
  static final HASDIALLED = amplify_core.QueryField(fieldName: "hasDialled");
  static final ISVOICECALL = amplify_core.QueryField(fieldName: "isVoiceCall");
  static final TIMESTAMP = amplify_core.QueryField(fieldName: "timestamp");
  static final PUSHTOKEN = amplify_core.QueryField(fieldName: "pushToken");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CallModel";
    modelSchemaDefinition.pluralName = "CallModels";
    
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
      key: CallModel.CALLERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.CALLERNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.RECEIVERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.RECEIVERPIC,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.CALLID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.HASDIALLED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.ISVOICECALL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.TIMESTAMP,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CallModel.PUSHTOKEN,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

class _CallModelModelType extends amplify_core.ModelType<CallModel> {
  const _CallModelModelType();
  
  @override
  CallModel fromJson(Map<String, dynamic> jsonData) {
    return CallModel.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'CallModel';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [CallModel] in your schema.
 */
class CallModelModelIdentifier implements amplify_core.ModelIdentifier<CallModel> {
  final String id;

  /** Create an instance of CallModelModelIdentifier using [id] the primary key. */
  const CallModelModelIdentifier({
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
  String toString() => 'CallModelModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CallModelModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}