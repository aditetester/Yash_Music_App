
import 'package:boilerplate_new_version/domain/entity/recent_play_list/recent_play_list.dart';

class AllRecentList {
  final List<RecentPlayListModule>? MusicListData;

  AllRecentList({this.MusicListData});

  factory AllRecentList.fromJson(List<dynamic> json) {
    
    List<RecentPlayListModule> MusicListData = <RecentPlayListModule>[];
    
    MusicListData =  json.map((music) => RecentPlayListModule.fromMap(music)).toList();
  
    return AllRecentList(MusicListData: MusicListData);
  }
}
