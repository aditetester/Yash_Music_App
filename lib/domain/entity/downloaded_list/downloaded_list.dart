
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';

class AllDownloadedList {
  final List<DownloadedListModule>? DownloadedListData;

  AllDownloadedList({this.DownloadedListData});

  factory AllDownloadedList.fromJson(List<Map<String, dynamic>> json) {
    
    List<DownloadedListModule> DownloadedListData = <DownloadedListModule>[];
    
    DownloadedListData =  json.map((music) => DownloadedListModule.fromMap(music)).toList();
  
    return AllDownloadedList(DownloadedListData: DownloadedListData);
  }
}
