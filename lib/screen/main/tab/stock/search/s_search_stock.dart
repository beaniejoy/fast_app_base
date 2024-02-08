import 'package:fast_app_base/screen/main/tab/stock/search/popular_search_stock_list.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/search_stock_data.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_search_auto_complete_list.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_search_history_stock_list.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_stock_search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStockScreen extends StatefulWidget {
  const SearchStockScreen({super.key});

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> with SearchStockDataProvider{
  final controller = TextEditingController();

  // initState는 해당 클래스 생성자가 생성될 때 호출되지 않기 때문에
  // Get.put은 생성자 호출 이후에 이루어짐
  // 그래서 late로 searchData 호출되는 시점에 초기화가 이루어짐
  @override
  void initState() {
    // text controller 변화에 따라 안에 callback 메소드가 실행
    Get.put(SearchStockData());
    controller.addListener(() {
      searchData.search(controller.text);
      // setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SearchStockData>();
    super.dispose();
  }

  // ListView에서 몇 백개가 넘는 데이터들을 담으려고 하면 성능이슈 발생할 수 있기에
  // TODO: ListView.builder를 사용하면 된다 << 찾아볼 것
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockSearchAppBar(controller: controller),
      // Obx를 통해 Getx에서 변경된 RxList를 반영하도록 해준다(Obx 선언된 부분만 갱신)
      body: Obx(
        () => searchData.autoCompleteList.isEmpty
            ? ListView(
                children: const [
                  SearchHistoryStockList(),
                  PopularSearchStockList(),
                ],
              )
            : SearchAutoCompleteList(controller),
      ),
    );
  }
}
