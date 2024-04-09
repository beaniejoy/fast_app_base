import 'package:animations/animations.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/popular_stock_dummy.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/s_stock_detail_screen.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_popular_stock_item.dart';
import 'package:flutter/material.dart';

class PopularSearchStockList extends StatelessWidget {
  const PopularSearchStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            '인기 검색'.text.bold.make(),
            emptyExpanded,
            '오늘 ${DateTime.now().formattedTime}'.text.size(12).make()
          ],
        ),
        height20,
        ...popularStocks
            .mapIndexed(
              (element, index) => OpenContainer<bool>(
                openColor: context.backgroundColor,
                closedColor: context.backgroundColor,
                openBuilder: (BuildContext context, VoidCallback _) {
                  return StockDetailScreen(element.name);
                },
                closedBuilder: (BuildContext context, VoidCallback action) {
                  return PopularStockItem(
                    stock: element,
                    number: index + 1,
                  );
                },
              ),
            )
            .toList()
      ],
    ).pSymmetric(h: 20);
  }
}
