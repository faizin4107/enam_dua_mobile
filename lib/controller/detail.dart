import 'package:dio/dio.dart';
import 'package:enam_dua_teknologi/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailController extends GetxController with StateMixin<List<dynamic>> {
  var messageEmpty = ''.obs;
  setMessageEmpty(String val) {
    messageEmpty.value = val;
  }

  var messageError = ''.obs;
  setMessageError(String val) {
    messageError.value = val;
  }

  var listRecords = [].obs;
  setListRecords(List<dynamic> val) {
    listRecords.value = val;
  }

  var listPhotos = [].obs;
  setListPhotos(List<dynamic> val) {
    listPhotos.value = val;
  }

  var listOpenHours = [].obs;
  setListOpenHours(List<dynamic> val) {
    listOpenHours.value = val;
  }

  var loading = false.obs;
  setLoading(bool val) {
    loading.value = val;
  }

  var dataNotFound = false.obs;
  setDataNotFound(bool val) {
    dataNotFound.value = val;
  }

  var searchEmpty = true.obs;
  setSearchEmpty(bool val) {
    searchEmpty.value = val;
  }

  var openNow = true.obs;
  setOpenNow(bool val) {
    openNow.value = val;
  }

  CancelToken cancelToken = CancelToken();
  Future getData(id) async {
    setLoading(true);
    cancelToken = CancelToken();
    listRecords.clear();
    listPhotos.clear();
    listOpenHours.clear();
    Map<dynamic, dynamic> result = {};
    change(null, status: RxStatus.loading());
    var path = '/';
    await APIServices.getApi(path, id, cancelToken).then((response) {
      // debugPrint('response ${response}');
      if (response != null) {
        result = response;
        if (result['success'] == false) {
          if (result.containsKey('message')) {
            setLoading(false);
            setMessageError(result['message']);
            return change(null, status: RxStatus.error(result['message']));
          }
        } else {
          if (result.containsKey('photos')) {
            debugPrint('ya ${result['photos']}');
            var photos = result['photos'];

            setListPhotos(photos);
          }
          if (result.containsKey('hours')) {
            // debugPrint('ya ${result['photos']}');

            var hours = result['hours'];

            // debugPrint('hours $hours');
            for (var i in hours) {
              Map<String, dynamic> data = i;
              if (data.containsKey('is_open_now')) {
                setOpenNow(data['is_open_now']);
              }
              if (data.containsKey('open')) {
                // debugPrint('open $open');
                // listOpenHours.add(data['open']);
                setListOpenHours(data['open']);
              }
            }

            // setListCategories(categories);
          }
          listRecords.add(result);
          setDataNotFound(false);
          setLoading(false);

          // debugPrint('records ${listRecords}');

          return change(listRecords, status: RxStatus.success());
        }
      }
    });
  }



}
