import 'package:fast_app_base/common/util/local_json.dart';
import 'package:fast_app_base/screen/main/tab/stock/vo/vo_simple_stock.dart';
import 'package:get/get.dart';

abstract mixin class SearchStockDataProvider {
  // mixin class 안에 선언하는 변수명은 최대한 유니크하게 명명하는 것이 좋다
  // mixin을 여러 개 사용하거나 mixin을 사용하는 클래스에서 변수명이 꼬일 수 있다.
  late final searchData = Get.find<SearchStockData>();
}

// vuex와 비슷 (상태관리)
// RxList > 화면에 바로 반영해주는 Getx 데이터 타입
// obs > observation
class SearchStockData extends GetxController {
  List<SimpleStock> stocks = [];
  RxList<String> searchHistoryList = <String>[].obs;
  RxList<SimpleStock> autoCompleteList = <SimpleStock>[].obs;

  // GetxController 생성시 최초 호출되는 함수
  @override
  void onInit() {
    searchHistoryList.addAll(['삼성전자', 'LG전자', '현대차', '넷플릭스']);
    loadLocalStockJson(); // 여기서 api 응답 받아서 사용해도 될듯
    
    super.onInit();
  }

  Future<void> loadLocalStockJson() async{
    final jsonList = await LocalJson.getObjectList<SimpleStock>("json/stock_list.json");
    stocks.addAll(jsonList);
  }

  void search(String keyword) {
    if (keyword.isEmpty) {
      autoCompleteList.clear();
      return;
    }

    // .value > 할당
    autoCompleteList.value =
        stocks.where((element) => element.name.contains(keyword)).toList();
  }

  void addHistory(SimpleStock stock) {
    final stockName = stock.name;
    if (searchHistoryList.contains(stockName)) {
      return;
    }

    searchHistoryList.add(stockName);
  }

  void removeHistory(String stockName) {
    searchHistoryList.remove(stockName);
  }
}
