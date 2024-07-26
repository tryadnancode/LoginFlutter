/// @Created by akash on 26-07-2024.
/// Know more about author at https://akash.cloudemy.in
abstract class UiState<T> {
  const UiState();
}

class Success<T> extends UiState<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends UiState<T> {
  final String msg;
  const Error(this.msg);
}

class Loading<T> extends UiState<T> {
  const Loading();
}
class None<T> extends UiState<T> {
  const None();
}
/*

void handleState(UiState state) {
  switch (state.runtimeType) {
    case Success:
    // ProgressDialog.hide();
      var data=(state as Success).data;
      break;
    case Error:
    //  ProgressDialog.hide();
      var error=(state as Error).msg;
      break;
    case Loading:
    //  ProgressDialog.show();
      break;
  }
}*/
