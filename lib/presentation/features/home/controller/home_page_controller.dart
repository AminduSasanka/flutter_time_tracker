import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/home_page_state.dart';

class HomePageController extends AutoDisposeNotifier<HomePageState> {
  @override
  HomePageState build() {
    return HomePageState.initial();
  }
}