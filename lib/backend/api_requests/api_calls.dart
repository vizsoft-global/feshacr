import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start OTPless Group Code

class OTPlessGroup {
  static String getBaseUrl({
    String? url =
        'https://proxy.vizsoft.in/https://nocodeplayground.onrender.com/',
  }) =>
      '${url}';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'x-requested-with': 'https://proxy.vizsoft.in',
  };
  static SendSMSCall sendSMSCall = SendSMSCall();
  static VerifySMSCall verifySMSCall = VerifySMSCall();
  static ResendSMSCall resendSMSCall = ResendSMSCall();
}

class SendSMSCall {
  Future<ApiCallResponse> call({
    String? phoneno = '',
    String? url =
        'https://proxy.vizsoft.in/https://nocodeplayground.onrender.com/',
  }) async {
    final baseUrl = OTPlessGroup.getBaseUrl(
      url: url,
    );

    final ffApiRequestBody = '''
{
  "phoneNumber": "${phoneno}",
  "otpLength": 6,
  "channel": "WHATSAPP",
  "expiry": 300
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SendSMS',
      apiUrl: '${baseUrl}send_opt_whatsapp',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? requestId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.orderId''',
      ));
}

class VerifySMSCall {
  Future<ApiCallResponse> call({
    String? requestId = '',
    String? otp = '',
    String? phoneno = '',
    String? url =
        'https://proxy.vizsoft.in/https://nocodeplayground.onrender.com/',
  }) async {
    final baseUrl = OTPlessGroup.getBaseUrl(
      url: url,
    );

    final ffApiRequestBody = '''
{
  "orderId": "${requestId}",
  "otp": "${otp}",
  "phoneNumber": "${phoneno}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VerifySMS',
      apiUrl: '${baseUrl}verify_opt_whatsapp',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? status(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.isOTPVerified''',
      ));
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic requestID(dynamic response) => getJsonField(
        response,
        r'''$.requestId''',
      );
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}

class ResendSMSCall {
  Future<ApiCallResponse> call({
    String? requestId = '',
    String? url =
        'https://proxy.vizsoft.in/https://nocodeplayground.onrender.com/',
  }) async {
    final baseUrl = OTPlessGroup.getBaseUrl(
      url: url,
    );

    final ffApiRequestBody = '''
{
  "orderId": "${requestId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ResendSMS',
      apiUrl: '${baseUrl}resend_opt_whatsapp',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.isOTPVerified''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic requestID(dynamic response) => getJsonField(
        response,
        r'''$.requestId''',
      );
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}

/// End OTPless Group Code

/// Start Myfatoorah Group Code

class MyfatoorahGroup {
  static String getBaseUrl({
    String? token =
        'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
    String? url = 'apitest',
  }) =>
      'https://proxy.vizsoft.in/https://${url}.myfatoorah.com/';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer [token]',
    'x-requested-with': 'https://proxy.vizsoft.in',
  };
  static InvoiceCall invoiceCall = InvoiceCall();
  static InvoiceStatusCall invoiceStatusCall = InvoiceStatusCall();
  static ExecuteCall executeCall = ExecuteCall();
}

class InvoiceCall {
  Future<ApiCallResponse> call({
    String? token =
        'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
    String? url = 'apitest',
  }) async {
    final baseUrl = MyfatoorahGroup.getBaseUrl(
      token: token,
      url: url,
    );

    final ffApiRequestBody = '''
{
  "CustomerName": "name",
  "NotificationOption": "ALL",
  "MobileCountryCode": "965",
  "CustomerMobile": "12345678",
  "CustomerEmail": "rohit@vizsoft.in",
  "InvoiceValue": 100,
  "DisplayCurrencyIso": "kwd",
  "CallBackUrl": "https://yoursite.com/success",
  "ErrorUrl": "https://yoursite.com/error",
  "WebhookUrl": "https://hook.us1.make.com/p7og7qm3g9v7amn2rdx6odh24brwvypj?project=feshah&&paymenttype=myfatoorah",
  "Language": "en",
  "CustomerReference": "ORDAZYA10087",
  "CustomerAddress": {
    "Block": "string",
    "Street": "string",
    "HouseBuildingNo": "string",
    "Address": "address",
    "AddressInstructions": "string"
  },
  "InvoiceItems": [
    {
      "ItemName": "string",
      "Quantity": 20,
      "UnitPrice": 5
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Invoice',
      apiUrl: '${baseUrl}v2/SendPayment',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic invoiceID(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceId''',
      );
  dynamic invoiceURL(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceURL''',
      );
}

class InvoiceStatusCall {
  Future<ApiCallResponse> call({
    String? invoiceId = '',
    String? token =
        'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
    String? url = 'apitest',
  }) async {
    final baseUrl = MyfatoorahGroup.getBaseUrl(
      token: token,
      url: url,
    );

    final ffApiRequestBody = '''
{
  "Key": "${escapeStringForJson(invoiceId)}",
  "KeyType": "Invoiceid"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Invoice Status',
      apiUrl: '${baseUrl}v2/GetPaymentStatus',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceStatus''',
      );
  dynamic invoiceID(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceId''',
      );
  dynamic invoiceAmount(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceValue''',
      );
  dynamic invoiceMethod(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceTransactions[1].PaymentGateway''',
      );
  dynamic paymentID(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceTransactions[1].PaymentId''',
      );
  dynamic referenceID(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceTransactions[1].ReferenceId''',
      );
  dynamic invoiceRef(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceReference''',
      );
  dynamic transactionID(dynamic response) => getJsonField(
        response,
        r'''$.Data.InvoiceTransactions[1].TransactionId''',
      );
}

class ExecuteCall {
  Future<ApiCallResponse> call({
    String? customerName = '',
    String? customerDailCode = '',
    String? customerPhone = '',
    String? customerEmail = '',
    double? programPrice,
    String? returnURL = '',
    String? orderId = '',
    String? cartInfo = '',
    String? paymentMethodID = '',
    String? webhookUrl = '',
    String? token =
        'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
    String? url = 'apitest',
  }) async {
    final baseUrl = MyfatoorahGroup.getBaseUrl(
      token: token,
      url: url,
    );

    final ffApiRequestBody = '''
{
  "PaymentMethodId": "${paymentMethodID}",
  "CustomerName": "${customerName}",
  "DisplayCurrencyIso": "KWD",
  "MobileCountryCode": "${customerDailCode}",
  "CustomerMobile": "${customerPhone}",
  "CustomerEmail": "${customerEmail}",
  "InvoiceValue": ${programPrice},
  "CallBackUrl": "${returnURL}",
  "ErrorUrl": "${returnURL}",
  "WebhookUrl": "${webhookUrl}",
  "Language": "en",
  "CustomerReference": "${orderId}",
  "UserDefinedField": "${cartInfo}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Execute',
      apiUrl: '${baseUrl}v2/ExecutePayment',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? invoiceID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.Data.InvoiceId''',
      ));
  String? paymentURL(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.Data.PaymentURL''',
      ));
}

/// End Myfatoorah Group Code

/// Start Upayment Group Code

class UpaymentGroup {
  static String getBaseUrl({
    String? url = 'sandboxapi',
    String? aPIkey = 'jtest123',
  }) =>
      'https://proxy.vizsoft.in/https://${url}.upayments.com/api/v1/';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [APIkey]',
    'accept': 'application/json',
    'content-type': 'application/json',
    'x-requested-with': 'https://proxy.vizsoft.in',
  };
  static ChargeCall chargeCall = ChargeCall();
  static StatusCall statusCall = StatusCall();
}

class ChargeCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? programRef = '',
    String? programTitle = '',
    String? programPrice = '',
    String? customerId = '',
    String? customerName = '',
    String? customerEmail = '',
    String? customerPhone = '',
    String? returnURL = '',
    String? cancelURL = '',
    String? notificationURL = '',
    String? url = 'sandboxapi',
    String? aPIkey = 'jtest123',
  }) async {
    final baseUrl = UpaymentGroup.getBaseUrl(
      url: url,
      aPIkey: aPIkey,
    );

    final ffApiRequestBody = '''
{
  "order": {
    "id": "${escapeStringForJson(orderId)}",
    "reference": "${escapeStringForJson(programRef)}",
    "description": "${escapeStringForJson(programTitle)}",
    "currency": "KWD",
    "amount": "${escapeStringForJson(programPrice)}"
  },
  "language": "en",
  "paymentGateway": {
    "src": "knet"
  },
  "reference": {
    "id": "${escapeStringForJson(orderId)}"
  },
  "customer": {
    "uniqueId": "${escapeStringForJson(customerId)}",
    "name": "${escapeStringForJson(customerName)}",
    "email": "${escapeStringForJson(customerEmail)}",
    "mobile": "${escapeStringForJson(customerPhone)}"
  },
  "returnUrl": "${escapeStringForJson(returnURL)}",
  "cancelUrl": "${escapeStringForJson(cancelURL)}",
  "notificationUrl": "${escapeStringForJson(notificationURL)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Charge',
      apiUrl: '${baseUrl}charge',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${aPIkey}',
        'accept': 'application/json',
        'content-type': 'application/json',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic chargeLink(dynamic response) => getJsonField(
        response,
        r'''$.data.link''',
      );
  dynamic chargeMessage(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class StatusCall {
  Future<ApiCallResponse> call({
    String? trackId = '',
    String? url = 'sandboxapi',
    String? aPIkey = 'jtest123',
  }) async {
    final baseUrl = UpaymentGroup.getBaseUrl(
      url: url,
      aPIkey: aPIkey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Status',
      apiUrl: '${baseUrl}get-payment-status/${trackId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${aPIkey}',
        'accept': 'application/json',
        'content-type': 'application/json',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {
        'trackId': trackId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic paymentID(dynamic response) => getJsonField(
        response,
        r'''$.data.transaction.payment_id''',
      );
  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.data.transaction.result''',
      );
  dynamic paymentTYPE(dynamic response) => getJsonField(
        response,
        r'''$.data.transaction.payment_type''',
      );
  dynamic paymentMETHOD(dynamic response) => getJsonField(
        response,
        r'''$.data.transaction.payment_method''',
      );
}

/// End Upayment Group Code

/// Start TAP Group Code

class TapGroup {
  static String getBaseUrl({
    String? secreatKey = '',
    String? url = 'https://proxy.vizsoft.in/https://api.tap.company/',
  }) =>
      '${url}v2/';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer [secreatKey]',
    'x-requested-with': 'https://proxy.vizsoft.in',
  };
  static ChargeAPICall chargeAPICall = ChargeAPICall();
  static StatusAPICall statusAPICall = StatusAPICall();
}

class ChargeAPICall {
  Future<ApiCallResponse> call({
    double? amount,
    String? productList = '',
    String? clientname = '',
    String? orderID = '',
    String? clientemail = '',
    String? clientphone = '',
    int? merchantid,
    String? postURL = '',
    String? redirectURL = '',
    String? secreatKey = '',
    String? url = 'https://proxy.vizsoft.in/https://api.tap.company/',
  }) async {
    final baseUrl = TapGroup.getBaseUrl(
      secreatKey: secreatKey,
      url: url,
    );

    final ffApiRequestBody = '''
{
  "amount": ${amount},
  "currency": "KWD",
  "threeDSecure": true,
  "save_card": false,
  "description": "${productList}",
  "statement_descriptor": "${clientname}",
  "metadata": {},
  "reference": {
    "transaction": "txn_0001",
    "order": "${orderID}"
  },
  "receipt": {
    "email": false,
    "sms": true
  },
  "customer": {
    "first_name": "${clientname}",
    "middle_name": "",
    "last_name": "",
    "email": "${clientemail}",
    "phone": {
      "country_code": "",
      "number": "${clientphone}"
    }
  },
  "merchant": {
    "id": "${merchantid}"
  },
  "source": {
    "id": "src_all"
  },
  "post": {
    "url": "${postURL}"
  },
  "redirect": {
    "url": "${redirectURL}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ChargeAPI',
      apiUrl: '${baseUrl}charge',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${secreatKey}',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic chargeId(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
  dynamic chargeUrl(dynamic response) => getJsonField(
        response,
        r'''$.transaction.url''',
      );
  dynamic changeRedirect(dynamic response) => getJsonField(
        response,
        r'''$.redirect.url''',
      );
  dynamic changePost(dynamic response) => getJsonField(
        response,
        r'''$.post.url''',
      );
}

class StatusAPICall {
  Future<ApiCallResponse> call({
    String? chargeid = '',
    String? secreatKey = '',
    String? url = 'https://proxy.vizsoft.in/https://api.tap.company/',
  }) async {
    final baseUrl = TapGroup.getBaseUrl(
      secreatKey: secreatKey,
      url: url,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'StatusAPI',
      apiUrl: '${baseUrl}charges/${chargeid}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${secreatKey}',
        'x-requested-with': 'https://proxy.vizsoft.in',
      },
      params: {
        'chargeid': chargeid,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic chargeId(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
  dynamic amount(dynamic response) => getJsonField(
        response,
        r'''$.amount''',
      );
  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
  dynamic merchantId(dynamic response) => getJsonField(
        response,
        r'''$.merchant.id''',
      );
  dynamic gatewayRef(dynamic response) => getJsonField(
        response,
        r'''$.reference.gateway''',
      );
  dynamic paymentRef(dynamic response) => getJsonField(
        response,
        r'''$.reference.payment''',
      );
  dynamic createdAt(dynamic response) => getJsonField(
        response,
        r'''$.transaction.created''',
      );
  dynamic paymentMethod(dynamic response) => getJsonField(
        response,
        r'''$.source.payment_method''',
      );
  dynamic paymentType(dynamic response) => getJsonField(
        response,
        r'''$.source.payment_type''',
      );
}

/// End TAP Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
