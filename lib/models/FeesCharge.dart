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


/** This is an auto generated class representing the FeesCharge type in your schema. */
class FeesCharge {
  final String? _audiocall;
  final String? _videoCall;
  final String? _isChat;

  String? get audiocall {
    return _audiocall;
  }
  
  String? get videoCall {
    return _videoCall;
  }
  
  String? get isChat {
    return _isChat;
  }
  
  const FeesCharge._internal({audiocall, videoCall, isChat}): _audiocall = audiocall, _videoCall = videoCall, _isChat = isChat;
  
  factory FeesCharge({String? audiocall, String? videoCall, String? isChat}) {
    return FeesCharge._internal(
      audiocall: audiocall,
      videoCall: videoCall,
      isChat: isChat);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeesCharge &&
      _audiocall == other._audiocall &&
      _videoCall == other._videoCall &&
      _isChat == other._isChat;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("FeesCharge {");
    buffer.write("audiocall=" + "$_audiocall" + ", ");
    buffer.write("videoCall=" + "$_videoCall" + ", ");
    buffer.write("isChat=" + "$_isChat");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  FeesCharge copyWith({String? audiocall, String? videoCall, String? isChat}) {
    return FeesCharge._internal(
      audiocall: audiocall ?? this.audiocall,
      videoCall: videoCall ?? this.videoCall,
      isChat: isChat ?? this.isChat);
  }
  
  FeesCharge copyWithModelFieldValues({
    ModelFieldValue<String?>? audiocall,
    ModelFieldValue<String?>? videoCall,
    ModelFieldValue<String?>? isChat
  }) {
    return FeesCharge._internal(
      audiocall: audiocall == null ? this.audiocall : audiocall.value,
      videoCall: videoCall == null ? this.videoCall : videoCall.value,
      isChat: isChat == null ? this.isChat : isChat.value
    );
  }
  
  FeesCharge.fromJson(Map<String, dynamic> json)  
    : _audiocall = json['audiocall'],
      _videoCall = json['videoCall'],
      _isChat = json['isChat'];
  
  Map<String, dynamic> toJson() => {
    'audiocall': _audiocall, 'videoCall': _videoCall, 'isChat': _isChat
  };
  
  Map<String, Object?> toMap() => {
    'audiocall': _audiocall,
    'videoCall': _videoCall,
    'isChat': _isChat
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "FeesCharge";
    modelSchemaDefinition.pluralName = "FeesCharges";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'audiocall',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'videoCall',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'isChat',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}