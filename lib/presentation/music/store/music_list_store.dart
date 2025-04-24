import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
import 'package:boilerplate_new_version/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'music_list_store.g.dart';

class MusicListStore = _MusicListStore with _$MusicListStore;

abstract class _MusicListStore with Store {
  // use cases:-----------------------------------------------------------------
  final GetMusiclistUsecase _getMusicListUseCase;


  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _MusicListStore(this._getMusicListUseCase, this.errorStore);

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllMusicList?> emptyMusicListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllMusicList?> fetchPostsFuture =
      ObservableFuture<AllMusicList?>(emptyMusicListResponse);

  @observable
  List<MusicListModule>? AllMusic;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchMusicList() async {
    final future = _getMusicListUseCase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);

    await future
        .then((MusicList) {
          AllMusic = MusicList.MusicListData;
        })
        .catchError((error) {
          errorStore.errorMessage = DioExceptionUtil.handleError(error);
        });
  }

  @action
  Future<void> SelectedMusicList(String subCategoryId) async {
    AllMusic =  AllMusic!
            .where((element) => element.subCategoryId == subCategoryId)
            .toList();

  }
}
