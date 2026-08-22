part of 'onbording_cubit.dart';

sealed class OnbordingState {}

final class OnbordingInitial extends OnbordingState {}

final class OnbordingPageChanged extends OnbordingState {
  final int pageIndex;

  OnbordingPageChanged(this.pageIndex);
}
