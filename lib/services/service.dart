import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http_parser/http_parser.dart';

class ServiceCommon {
  static ServiceCommon? instance;

  final String host = "http://45.76.209.56:9090/";
  final String hostImage = "http://45.76.209.56:9090/images/user/carphoto/";

  final String clientIdLoginApple =
      "com.hearts.mygarage.SigninServiceExtension";
  final String redirectUriApple =
      "https://snapdragon-nosy-paste.glitch.me/callbacks/sign_in_with_apple";
  final String notiIdApp = "dc2afc11-f2f7-4af1-a597-31b1fb96a10b";

  final String apiLogin = "ajax_chk_login_light.php";

  final String modeCheckDulicate = "chk_duplicate_email";
  final String modeLoginEmailAndPassword = "chk_login_email";
  final String modeLoginFb = "chk_login_fb";
  final String modeCheckPhoneExist = "chk_login_sms";
  final String modeRegister = "regist_user_email";
  final String modeSendEmail = "send_keycode";
  final String modeCheckCodeEmail = "chk_keycode";
  final String modeResetPassword = "request_password";
  final String modePushTalkboardComming = "push_talkboard_comming";

  String apiCar = "ajax_mygarage_light.php";

  final String modeGetCarMakerList = "get_car_maker_list";
  final String modeGetCarModelList = "get_car_model_list";
  final String modeGetCarFmcList = "get_car_fmc_list";
  final String modeGetCarMcList = "get_car_mc_list";
  final String modeGetCarGradeList = "get_car_grade_list";

  final String getCarCodeFromSeries = "get_car_code_from_series";
  final String modeGetCarRegister = "get_car_regist";
  final String modeRegisterCar = "set_car_regist";

  final String modeGetTimelineImprove = "get_timeline_improve";

  final String modeNiceIncrement = "nice_increment";
  final String modeNiceDecrement = "nice_decrement";
  final String modeGetMemberNiceList = "get_nice_member_list";
  final String modeUpDateToken = "update_push_token";
  final String modeGetNotification = "get_notification";
  final String modeUpdateNotification = "update_cst_notice";
  final String modeGetNoticeCount = "get_notice_count";
  final String modeGetDmHistory = "get_dm_history";

  final String modeGetTalkboardHeader = "get_talkboard_header";
  final String modeGetGarageList = "get_garage_list";
  final String modeUpdateCstCar = "update_cst_cars";
  final String modeUpdateCarsSpec = "update_cars_spec";

  final String modeDeleteCarCst = "delete_cst_car";

  final String modeCarSeqUpdate = "car_seq_update";
  final String modeGetMyCarDetail = "get_mycar_detail";
  final String modeGetNoticeData = "get_notice_data";
  final String modeGetQrReadListMore = "get_qr_read_list_more";
  final String modeGetMygarageGalleryList = "get_mygarage_gallery_list";
  final String modeGetCarSpecEdit = "get_carspec_edit";
  final String modeGetCarprofileEdit = "get_carprofile_edit";
  final String modeUpdateCarSpec = "update_cars_spec";
  final String modeGetCarSpec = "get_carspec_itemedit";

  final String modeGetCarProfileItem = "get_carprofile_itemedit";
  final String modeGetQrCode = "get_qrcode";

  final String apiComet = "comet_light.php";

  final String modeView = "view";
  final String modeAdd = "add";

  final String apiUpLoadFile = "img_upload_light.php";

  final String apiImageDelete = "img_delete.php";

  final String modeDeleteCarGallery = "gallery";

  static ServiceCommon? getInstance() {
    if (instance == null) instance = new ServiceCommon();
    return instance;
  }

  Future<Response> getHttp(
      {Map<String, dynamic>? param, required String api}) async {
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 100000, // 60 seconds
        receiveTimeout: 60 * 100000 // 60 seconds
        );

    Response response = await Dio(options).get(
      host + api,
      queryParameters: param,
    );
    return response;
  }

  Future<Response> getHttpQrReg({Map<String, dynamic>? param}) async {
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 100000, // 60 seconds
        receiveTimeout: 60 * 100000 // 60 seconds
        );

    Response response = await Dio(options).get(
      "https://mygare.jp/api/index.php",
      queryParameters: param,
    );
    return response;
  }

  Future<Response> postHttp(
      {Map<String, dynamic>? param, required String api}) async {
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 100000, // 60 seconds
        receiveTimeout: 60 * 100000 // 60 seconds
        );

    Response response = await Dio(options).post(
      host + api,
      queryParameters: param,
    );
    return response;
  }

  Future<Response> upLoadImageFile({
    required Map<String, dynamic>? param,
    required File file,
    required String fileName,
  }) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 90,
        targetWidth: 1200,
        targetHeight: (properties.height! * 1200 / properties.width!).round());

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(compressedFile.path,
          filename: fileName, contentType: MediaType('image', 'jpeg')),
    });

    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        maxRedirects: 1,
        connectTimeout: 60 * 100000, // 60 seconds
        receiveTimeout: 60 * 100000 // 60 seconds
        );

    Response response = await Dio(options).post(host + "img_upload_light.php",
        queryParameters: param, data: data);
    return response;
  }
}
