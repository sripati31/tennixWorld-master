import 'package:bloc/bloc.dart';
import 'package:TennixWorldXI/modules/createTeam/createTeamScreen.dart';

class TeamTapBloc extends Bloc<TeamTapBlocEvent, TeamTapBlocState> {
  var animationType = AnimationType.isRegular;

  TeamTapBloc(TeamTapBlocState initialState) : super(initialState);

  void cleanList() {
    animationType = AnimationType.isRegular;
    add(TeamTapBlocEvent.setUpdate);
  }

  void setType(AnimationType atype) {
    animationType = atype;
    add(TeamTapBlocEvent.setUpdate);
  }

  TeamTapBlocState get initialState => TeamTapBlocState.initial();

  @override
  Stream<TeamTapBlocState> mapEventToState(TeamTapBlocEvent event) async* {
    if (event == TeamTapBlocEvent.setUpdate) {
      yield state.copyWith(
        animationType: animationType,
      );
    }
  }
}

enum TeamTapBlocEvent { setUpdate }

class TeamTapBlocState {
  AnimationType? animationType = AnimationType.isRegular;

  TeamTapBlocState({
    this.animationType,
  });

  factory TeamTapBlocState.initial() {
    return TeamTapBlocState(
      animationType: AnimationType.isRegular,
    );
  }

  TeamTapBlocState copyWith({
    AnimationType? animationType,
  }) {
    return TeamTapBlocState(
      animationType: animationType ?? this.animationType,
    );
  }
}
