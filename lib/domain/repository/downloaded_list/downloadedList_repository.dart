import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';

abstract class downloadedListRepository {

  Future<AllDownloadedList> getDownloadedMusicList();

  Future<int> insert(DownloadedListModule params);
  
  
}