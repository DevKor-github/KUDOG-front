import 'package:intl/intl.dart';
import 'package:kudog/model/NoticeModel.dart';

String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
String sevenDaysAgo =
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 7)));
Filter overallFilter = Filter(
    startDate: sevenDaysAgo,
    endDate: formattedDate,
    page: 1);//기본 fliter설정 : 1주, 전체, 전체 
