import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/screen/intro_screen.dart';
import 'package:projects/auth/service/fire_user_rep.dart';
import 'package:projects/auth/widgets/log_reg_button.dart';
import 'package:projects/profile/bloc/profile_bloc.dart';
import 'package:projects/profile/bloc/profile_event.dart';
import 'package:projects/profile/bloc/profile_state.dart';
import 'package:projects/widgets/views/error_view.dart';
import 'package:projects/widgets/views/loading_view.dart';

import '../../auth/model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileBloc _profileBloc = ProfileBloc(FireUsersDataRepoImpl());

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
        ),
        body: BlocBuilder(
          bloc: _profileBloc..add(LoadProfileEvent()),
          builder: (context, state) {
            if (state is LoadedState) {
              return UserInfo(
                userData: state.userData!,
                profileBloc: _profileBloc,
              );
            } else if (state is LoadingState) {
              return const LoadingView();
            } else if (state is ErrorState) {
              return Column(children: [
                const ErrorView(),
                SignOutButton(profileBloc: _profileBloc)
              ]);
            }
            return Container();
          },
        ));
  }
}

class UserInfo extends StatelessWidget {
  final UserData userData;
  final ProfileBloc profileBloc;

  const UserInfo({Key? key, required this.userData, required this.profileBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15),
      child: Column(
        children: [
          ImageAndName(name: userData.name, imageURL: userData.photoURL),
          const SizedBox(
            height: 50,
          ),
          EmailText(
            email: userData.email,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SignOutButton(
                profileBloc: profileBloc,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ImageAndName extends StatelessWidget {
  final String imageURL;
  final String name;

  const ImageAndName({Key? key, required this.name, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(imageURL + '?width=9999'),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 30)),
        ],
      ),
    );
  }
}

class EmailText extends StatelessWidget {
  final String email;

  const EmailText({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: <TextSpan>[
      TextSpan(
        text: 'Email:  ',
        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 18),
      ),
      TextSpan(
        text: email,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 18, fontWeight: FontWeight.normal),
      ),
    ]));
  }
}

class SignOutButton extends StatelessWidget {
  final ProfileBloc profileBloc;

  const SignOutButton({Key? key, required this.profileBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: profileBloc,
        builder: (context, state) {
          return LogRegButton(
              nameButton: 'Sign out',
              onTap: () {
                profileBloc.add(SignOutEvent());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false);
              });
        });
  }
}
