import 'package:equatable/equatable.dart';

abstract class RouterState extends Equatable {
  const RouterState();
  @override
  List<Object?> get props => [];
}
class LoginPageState extends RouterState {
  final String? extraPageContent;
  const LoginPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class MainPageState extends RouterState {
  final String? extraPageContent;
  const MainPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class WelcomePageState extends RouterState {
  final String? extraPageContent;
  const WelcomePageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class DetailPostPageState extends RouterState {
  final String? extraPageContent;
  const DetailPostPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class RegistrationPageState extends RouterState {
  final String? extraPageContent;
  const RegistrationPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class RegistrationModelPageState extends RouterState {
  final String? extraPageContent;
  const RegistrationModelPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}