import 'package:dio/dio.dart';
import 'package:enam_dua_teknologi/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController with StateMixin<List<dynamic>> {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  final FocusNode focusNode = FocusNode();

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

  CancelToken cancelToken = CancelToken();
  Future getData(String text) async {
    cancelToken = CancelToken();
    Map<dynamic, dynamic> result = {};
    listRecords.clear();
    debugPrint('text 1 $text');

    if (text != '') {
      setSearchEmpty(false);
      debugPrint('text 2 $text');
      setLoading(true);
      change(null, status: RxStatus.loading());
      var path = '/search?location=newyork&term=';
      await APIServices.getApi(path, searchController.value.text, cancelToken)
          .then((response) {
        if (response != null) {
          result = response;
          if (result['success'] == false) {
            if (result.containsKey('message')) {
              setLoading(false);
              setMessageError(result['message']);
              return change(null, status: RxStatus.error(result['message']));
            }
          } else {
            if (result.containsKey('total')) {
              if (result['total'] == 0) {
                setDataNotFound(true);
                setLoading(false);

                setMessageEmpty('Data not found');
                return change(null, status: RxStatus.empty());
              } else {
                // Bussiness.fromJson(result['bussiness']);
                if (result.containsKey('businesses')) {
                  setListRecords(result['businesses']);
                } else {
                  setListRecords([]);
                }
                setDataNotFound(false);
                setLoading(false);

                return change(listRecords, status: RxStatus.success());
              }
            }
          }
        }
      });
    } else {
      setSearchEmpty(true);
      setMessageEmpty('Data not found');
      return change(null, status: RxStatus.empty());
    }
  }



}
