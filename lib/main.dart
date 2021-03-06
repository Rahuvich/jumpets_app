import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jumpets_app/app_localizations.dart';
import 'package:jumpets_app/blocs/ads_bloc/ads_bloc.dart';
import 'package:jumpets_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:jumpets_app/blocs/bloc_delegate.dart';
import 'package:jumpets_app/blocs/error_handler_bloc/error_handler_bloc.dart';
import 'package:jumpets_app/blocs/favs_bloc/favourites_bloc.dart';
import 'package:jumpets_app/blocs/info_handler_bloc/info_handler_bloc.dart';
import 'package:jumpets_app/blocs/locale_bloc/locale_bloc.dart';
import 'package:jumpets_app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:jumpets_app/blocs/search_bloc/search_ads_bloc.dart';
import 'package:jumpets_app/blocs/theme_bloc/theme_bloc.dart';
import 'package:jumpets_app/data/repositories/ads_repository.dart';
import 'package:jumpets_app/data/repositories/authentication_repository.dart';
import 'package:jumpets_app/data/repositories/general_repository.dart';
import 'package:jumpets_app/data/repositories/user_repository.dart';
import 'package:jumpets_app/route_generator.dart';
import 'package:jumpets_app/ui/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:jumpets_app/ui/components/graphql_provider.dart';
import 'package:jumpets_app/ui/components/listeners/auth_listener.dart';
import 'package:overlay_support/overlay_support.dart';

import 'blocs/delete_ads/delete_ads_bloc.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await DotEnv().load('.env');
  await initHiveForFlutter();

  Bloc.observer = BlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();

  runApp(MyApp(
    adsRepository: AdsRepository(),
    authenticationRepository: AuthenticationRepository(),
    generalRepository: GeneralRepository(),
    userRepository: UserRepository(),
    errorBloc: ErrorHandlerBloc(),
    infoBloc: InfoHandlerBloc(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp(
      {@required this.adsRepository,
      @required this.authenticationRepository,
      @required this.generalRepository,
      @required this.userRepository,
      @required this.errorBloc,
      @required this.infoBloc})
      : assert(authenticationRepository != null),
        assert(userRepository != null),
        assert(adsRepository != null),
        assert(generalRepository != null),
        assert(errorBloc != null),
        authBloc = AuthBloc(
          authenticationRepository: authenticationRepository,
          errorBloc: errorBloc,
          infoBloc: infoBloc,
        ),
        localeBloc = LocaleBloc('en');

  final AuthBloc authBloc;
  final ErrorHandlerBloc errorBloc;
  final InfoHandlerBloc infoBloc;
  final LocaleBloc localeBloc;
  final AdsRepository adsRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final GeneralRepository generalRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: RepositoryProvider.value(
        value: userRepository,
        child: RepositoryProvider.value(
          value: adsRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<DeleteAdsBloc>(
                  create: (context) => DeleteAdsBloc(
                      repository: adsRepository,
                      authBloc: authBloc,
                      errorBloc: errorBloc)),
              BlocProvider<RoomsBloc>(
                  create: (context) => RoomsBloc(
                      repository: userRepository,
                      authBloc: authBloc,
                      errorBloc: errorBloc)),
              BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
              BlocProvider<InfoHandlerBloc>(
                create: (context) => infoBloc,
              ),
              BlocProvider<ErrorHandlerBloc>(
                create: (context) => errorBloc,
              ),
              BlocProvider<LocaleBloc>(
                create: (context) => localeBloc,
              ),
              BlocProvider<AdsBloc>(
                create: (context) => AdsBloc(
                    generalRepository: generalRepository,
                    repository: adsRepository,
                    authBloc: authBloc,
                    errorBloc: errorBloc)
                  ..add(AdsFetched()),
              ),
              BlocProvider<AuthBloc>(
                create: (context) => authBloc,
              ),
              BlocProvider<FavouritesBloc>(
                  create: (context) => FavouritesBloc(
                      repository: adsRepository,
                      authBloc: authBloc,
                      errorBloc: errorBloc)),
              BlocProvider<SearchAdsBloc>(
                create: (context) => SearchAdsBloc(
                    repository: adsRepository,
                    errorBloc: errorBloc,
                    authBloc: authBloc),
              ),
            ],
            child: AuthListener(
              child: BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, state) {
                  return MyGraphQLProvider(
                    child: OverlaySupport(
                      child: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            locale: Locale(state.code),
                            title: 'PetsWorld',
                            theme: AppTheme.getTheme(
                                isLight: themeState is LightTheme),
                            onGenerateRoute: RouteGenerator.generateRoute,
                            initialRoute: '/',
                            supportedLocales: [
                              const Locale('en', 'US'),
                              const Locale('es', 'ES'),
                              const Locale('ca', 'CA'),
                            ],
                            localizationsDelegates: [
                              AppLocalizations.delegate,
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate
                            ],
                            localeResolutionCallback:
                                (locale, supportedLocales) {
                              for (var supportedLocale in supportedLocales) {
                                if (supportedLocale.languageCode ==
                                    locale.languageCode) {
                                  return supportedLocale;
                                }
                              }
                              return supportedLocales.first;
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
