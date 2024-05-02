import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';



import 'petite_storage.dart';

// class GenericService {
//   var token = StorageUtil.getString(key: "token");
//   Future<dynamic> postRequest({
//     required String endpoint,
//     required dynamic body,
//     required BuildContext context,
//   }) async {
//     try {
//       // logg("Encoded " + Uri.parse(endpoint).toString());
//       Response response = await post(
//         Uri.parse(endpoint),
//         headers: {
//           'Content-Type': 'application/json; charset=utf-8',
//           'Authorization': 'Bearer $token'
//         },
//         body: json.encoder.convert(body),
//       );
//       // log(loginResponseModel.access_token);
//       // log(json.encoder.convert(body));
//       if (response.statusCode == 401) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         // return postRequest(endpoint: endpoint, body: body, context: context);
//       } else {
//         final dynamic responseData =
//             json.decode(response.body);
//         print("$endpoint ==>$responseData");
//         return {
//           'data': responseData,
//           "status": '${response.statusCode}'
//         };
//       }
//     } catch (e) {
//       return {"reason": "Error $e"};
//     }
//   }
//
//   Future<Map<String, dynamic>> multipartPostRequest({
//     required String endpoint,
//     required dynamic body,
//     BuildContext? ctx,
//   }) async {
//     var returnData = <String, dynamic>{};
//     BuildContext context = ctx!;
//     var request =
//         MultipartRequest('POST', Uri.parse(endpoint));
//
//     print("-->1");
//     request.headers["content-type"] = "multipart/form-data";
//     request.headers["Authorization"] = "Bearer $token";
//     // request.fields.addAll(body);
//     request.files.add(body);
//     print("Request is ${request.fields}");
//
//     try {
//       final response = await request.send();
//       var responseData =
//           await Response.fromStream(response);
//       print(
//           "The $endpoint response is ${responseData.body}");
//       if (response.statusCode == 401) {
//         await Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         return multipartPostRequest(
//             endpoint: endpoint, body: body);
//       } else {
//         returnData = {
//           "status": responseData.statusCode,
//           "data": json.decode(responseData.body)
//         };
//         return returnData;
//       }
//     } catch (e) {
//       return {"reason": "Error $e", "status": "0000"};
//     }
//   }
//
//   Future<Map<String, dynamic>>
//       multipartPostRequestWithFiles({
//     required String endpoint,
//     required dynamic body,
//     required List<String> files,
//     String? json_key,
//     required ctx,
//   }) async {
//     var returnData = <String, dynamic>{};
//     BuildContext context = ctx!;
//     var request =
//         MultipartRequest('POST', Uri.parse(endpoint));
//
//     // print("-->1");
//     // request.headers["content-type"] = "multipart/form-data";
//     request.headers["Authorization"] = "Bearer $token";
//     request.files.add(MultipartFile.fromBytes(
//         json_key ?? "shelf_type",
//         utf8.encode(jsonEncode(body)),
//         contentType: MediaType("application", "json")));
//
//     for (var file in files) {
//       var multipartFile =
//           await MultipartFile.fromPath('files', file);
//       request.files.add(multipartFile);
//     }
//
//     print("Request is ${request.fields}");
//
//     try {
//       final response = await request.send();
//       var responseData =
//           await Response.fromStream(response);
//       print(
//           "The $endpoint response is ${responseData.body}");
//       if (response.statusCode == 401) {
//         await Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         return multipartPostRequestWithFiles(
//             endpoint: endpoint,
//             body: body,
//             files: files,
//             ctx: ctx);
//       } else {
//         returnData = {
//           "status": responseData.statusCode,
//           "data": json.decode(responseData.body)
//         };
//         return returnData;
//       }
//     } catch (e) {
//       return {"reason": "Error $e", "status": "0000"};
//     }
//   }
//
//   Future<Map<String, dynamic>> putRequestWithFiles({
//     required String endpoint,
//     required dynamic body,
//     required List<String> files,
//     String? json_key,
//     required ctx,
//   }) async {
//     var returnData = <String, dynamic>{};
//     BuildContext context = ctx;
//     var request =
//         MultipartRequest('PUT', Uri.parse(endpoint));
//
//     // print("-->1");
//     request.headers["content-type"] = "multipart/form-data";
//     request.headers["Authorization"] = "Bearer $token";
//     request.fields.addAll(body);
//
//     for (var file in files) {
//       var multipartFile =
//           await MultipartFile.fromPath('file', file);
//       request.files.add(multipartFile);
//     }
//
//     print("Request is ${request.fields}");
//
//     try {
//       final response = await request.send();
//       var responseData =
//           await Response.fromStream(response);
//       print(
//           "The $endpoint response is ${responseData.body}");
//       if (response.statusCode == 401) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         return multipartPostRequestWithFiles(
//             endpoint: endpoint,
//             body: body,
//             files: files,
//             ctx: ctx);
//       } else {
//         returnData = {
//           "status": responseData.statusCode,
//           "data": json.decode(responseData.body)
//         };
//         return returnData;
//       }
//     } catch (e) {
//       return {"reason": "Error $e", "status": "0000"};
//     }
//   }
//
//   Future<Map<String, dynamic>> multipartPostRequestCustom({
//     required String endpoint,
//     required dynamic body,
//     required title,
//     required ctx,
//   }) async {
//     var returnData = <String, dynamic>{};
//     BuildContext context = ctx;
//     var request =
//         MultipartRequest('POST', Uri.parse(endpoint));
//
//     // print("-->1");
//     // request.headers["content-type"] = "multipart/form-data";
//     request.headers["Authorization"] = "Bearer $token";
//     request.files.add(MultipartFile.fromBytes(
//         title, utf8.encode(jsonEncode(body)),
//         contentType: MediaType("application", "json")));
//
//     print("Request is ${request.fields}");
//
//     try {
//       final response = await request.send();
//       var responseData =
//           await Response.fromStream(response);
//       print(
//           "The $endpoint response is ${responseData.body}");
//       if (response.statusCode == 401) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         return multipartPostRequestCustom(
//             endpoint: endpoint,
//             body: body,
//             title: title,
//             ctx: ctx);
//       } else {
//         returnData = {
//           "status": responseData.statusCode,
//           "data": json.decode(responseData.body)
//         };
//         return returnData;
//       }
//     } catch (e) {
//       return {"reason": "Error $e", "status": "0000"};
//     }
//   }
//
//   Future<dynamic> putRequest({
//     required String endpoint,
//     required body,
//     BuildContext? ctx,
//   }) async {
//     BuildContext context = ctx!;
//
//     try {
//       Response response = await put(
//         Uri.parse(endpoint),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//         body: body == null
//             ? null
//             : json.encoder.convert(body),
//       );
//       if (response.statusCode == 401) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         // return putRequest(endpoint: endpoint, body: body);
//       } else {
//         final Map<String, dynamic> responseData =
//             json.decode(response.body);
//         return {
//           'status': response.statusCode,
//           "data": responseData,
//         };
//       }
//     } catch (e) {
//       return {
//         'status': "---",
//         "reason": "Error $e",
//       };
//     }
//   }
//
//   Future<dynamic> getRequest({
//     required String endpoint,
//     BuildContext? ctx,
//   }) async {
//     BuildContext context = ctx!;
//     try {
//       Response response = await get(
//         Uri.parse(endpoint),
//         headers: {
//           'Content-Type':
//               'application/x-www-form-urlencoded',
//           'Authorization':
//               'Bearer ${StorageUtil.getString(key: "token")}',
//
//           // 'Authorization': 'Bearer ea5x97EG0Yoxr1FmeiGqoFq0WbY60k',
//           // 'JWTAUTH':
//           //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjoiM2MwMTIyNGEtODlhNy00YWRjLTgxNDEtZWYzYmNiNzExZTJmIiwicm9sZXMiOltdLCJleHAiOjI1NTY1NTcxNDgsImlhdCI6MTY5MjU1NzE0OCwiYXVkIjoidXJuOmpzdCJ9.YM7ucXOinudyMMa4kUq6Hvt13mDfbkRwgS1VA5aq2T2P4xpb1hvJO4pFT9uDtTkhhVrw6fFS1jfVutF2YiKgPA'
//         },
//       );
//       if (response.statusCode == 403) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         // return getRequest(endpoint: endpoint, ctx: ctx);
//       } else {
//         final responseData = json.decode(response.body);
//         return {
//           'data': responseData,
//           "status": response.statusCode,
//         };
//       }
//     } catch (e) {
//       return {"reason": "Error $e"};
//     }
//   }
//
//   Future<dynamic> getRequestNoAuth({
//     required String endpoint,
//     BuildContext? ctx,
//   }) async {
//     BuildContext context = ctx!;
//
//     try {
//       Response response = await get(
//         Uri.parse(endpoint),
//         headers: {
//           'Content-Type':
//               'application/x-www-form-urlencoded',
//           // 'Authorization': 'Bearer ${loginResponseModel.access_token}'
//         },
//       );
//       if (response.statusCode == 401) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         // return getRequest(endpoint: endpoint, ctx: ctx);
//       } else {
//         final responseData = json.decode(response.body);
//         return {
//           'data': responseData,
//           "status": response.statusCode,
//         };
//       }
//     } catch (e) {
//       return {"reason": "Error $e"};
//     }
//   }
//
//   Future<dynamic> deleteRequest({
//     required String endpoint,
//     BuildContext? ctx,
//   }) async {
//     BuildContext context = ctx!;
//
//     try {
//       Response response = await delete(
//         Uri.parse(endpoint),
//         headers: {
//           'Content-Type':
//               'application/x-www-form-urlencoded',
//           'Authorization': 'Bearer $token'
//         },
//       );
//       if (response.statusCode == 401) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) =>
//                   const LoginScreen(),
//             ),
//             (route) => false);
//         return deleteRequest(endpoint: endpoint);
//       } else {
//         final responseData = json.decode(response.body);
//         return {
//           'data': responseData,
//           "status": response.statusCode,
//         };
//       }
//     } catch (e) {
//       return {"reason": "Error $e"};
//     }
//   }
// }
