import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(): super(0);

  @override
  Stream<int> mapEventToState(CounterEvent evt) async* {
    switch (evt) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
        break;
      default:
        addError(Exception('unhandled event: $evt'));
    }
  }
}
