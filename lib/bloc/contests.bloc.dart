import 'package:bloc/bloc.dart';
import 'package:superworldcon/apis/contests.dart';

enum ContestListEvent { fetch }

class ContestListBloc extends Bloc<ContestListEvent, List<ContestListResponse>> {
  ContestListBloc(): super([]) {
    this.add(ContestListEvent.fetch);
  }

  @override
  Stream<List<ContestListResponse>> mapEventToState(ContestListEvent evt) async* {
    switch (evt) {
      case ContestListEvent.fetch:
        final contests = await fetchContests();
        yield contests;
        break;
      default:
        addError(Exception('unhandled event: $evt'));
    }
  }
}
