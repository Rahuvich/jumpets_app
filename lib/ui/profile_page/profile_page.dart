import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jumpets_app/app_localizations.dart';
import 'package:jumpets_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:jumpets_app/blocs/error_handler_bloc/error_handler_bloc.dart';
import 'package:jumpets_app/blocs/profile_bloc/profile_bloc.dart';
import 'package:jumpets_app/blocs/search_bloc/search_ads_bloc.dart'
    as independentSearchBloc;
import 'package:jumpets_app/blocs/valuations_bloc/valuations_bloc.dart';
import 'package:jumpets_app/data/repositories/user_repository.dart';
import 'package:jumpets_app/models/models.dart';
import 'package:jumpets_app/models/users/user.dart';

import 'package:jumpets_app/ui/components/profile_icon.dart';
import 'package:jumpets_app/ui/components/user_chip.dart';
import 'package:jumpets_app/ui/profile_page/profile_body.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  ProfilePage({@required this.user}) : assert(user != null);
  @override
  _ProfilePageState createState() => _ProfilePageState(user);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState(this.user);
  User user;
  @override
  void initState() {
    super.initState();

    context.bloc<independentSearchBloc.SearchAdsBloc>()
      ..add(independentSearchBloc.AdsSearched(creator: user.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
          user: user,
          errorBloc: context.bloc<ErrorHandlerBloc>(),
          repository: RepositoryProvider.of<UserRepository>(context))
        ..add(UserFetched()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          setState(() {
            user = state.user;
          });
        },
        child: BlocBuilder<independentSearchBloc.SearchAdsBloc,
            independentSearchBloc.SearchAdsState>(
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) => _build(
                    context,
                    state.authStatus.status.isAuthenticated &&
                        state.authStatus.authData.user.id == user.id));
          },
        ),
      ),
    );
  }

  Widget _build(BuildContext context, bool isMyProfile) {
    var actionsList = isMyProfile
        ? [
            IconButton(
              icon: Icon(Icons.edit),
              iconSize: 22,
              onPressed: () => Navigator.pushNamed(context, '/edit_profile',
                  arguments: context
                      .bloc<AuthBloc>()
                      .state
                      .authStatus
                      ?.authData
                      ?.user),
            ),
            IconButton(
              icon: Icon(Icons.menu),
              iconSize: 22,
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            ),
          ]
        : <Widget>[];

    return BlocProvider<ValuationsBloc>(
      create: (context) => ValuationsBloc(
          errorBloc: context.bloc<ErrorHandlerBloc>(),
          repository: RepositoryProvider.of<UserRepository>(context),
          authBloc: context.bloc<AuthBloc>()),
      child: BlocListener<ValuationsBloc, ValuationsState>(
          listenWhen: (previous, current) =>
              previous.status == FormzStatus.submissionInProgress &&
              current.status == FormzStatus.submissionSuccess &&
              current.user != null,
          listener: (context, state) {
            context.bloc<ProfileBloc>().add(UserUpdated(user: state.user));
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              centerTitle: true,
              actions: actionsList,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 0, bottom: 20, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RoundedRectProfileThumb(
                          borderRadius: 20,
                          height: 130,
                          width: 150,
                          borderWidth: 0,
                          user: user,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(user.name,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    UserChip(
                                      paddingValue: 0,
                                      withBorder: true,
                                      user: user,
                                      tag: user.id,
                                    ),
                                    if (!user.isParticular)
                                      SizedBox(
                                        width: 10,
                                      ),
                                    user.oneStarWidget,
                                    Text(user.valuationAvg.toStringAsFixed(1))
                                  ],
                                ),
                              ),
                              if (user.address != null)
                                SelectableText(
                                  user.address,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              if (user.phone != null)
                                SelectableText(
                                  user.phone.toString(),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              if (user.isProfesional &&
                                  (user as Profesional).web != null)
                                SelectableText(
                                  (user as Profesional).web.toString(),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              if (user.isProtectora &&
                                  (user as Protectora).web != null)
                                SelectableText(
                                  (user as Protectora).web.toString(),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: ProfileBody(user: user)),
              ],
            ),
          )),
    );
  }

  bool get hasWeb =>
      (user.isProtectora && (user as Protectora).web != null) ||
      (user.isProfesional && (user as Profesional).web != null);
}
