import 'package:flutter/material.dart';
import 'package:kelas_baca/api/kelas_baca_services.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class ProfileScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.profilePath,
      key: ValueKey(AppPages.profilePath),
      child: ProfileScreen(),
    );
  }

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserApp user;
  late TextTheme textTheme;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    final userservice =
        Provider.of<Service>(context, listen: false).getUserData!;
    if (userservice != null) {
      user = userservice;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.blueAccent,
          body: Stack(fit: StackFit.expand, children: [
            Positioned(
              left: 0,
              top: 10,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  child: Icon(Icons.arrow_back)),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buldProfile(context),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(35),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0))),
                        child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            children: [
                              _buildEditProfile(),
                              _buildResetPassword(),
                              _buildLogout(context),
                            ])))
              ],
            )
          ])),
    );
  }

  Widget _buildEditProfile() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
      child: Center(
        child: InkWell(
          onTap: () async {
            //TODO

            // await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         EditProfileWidget(),
            //   ),
            // );
          },
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text('Edit Profil', style: textTheme.bodyText1),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.9, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF95A1AC),
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPassword() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: Center(
        child: InkWell(
          onTap: () async {
            //TODO

            // await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         ChangePasswordWidget(),
            //   ),
            // );
          },
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text('Reset Password', style: textTheme.bodyText1),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.9, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF95A1AC),
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogout(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            primary: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
          ),
          onPressed: () async {
            //Navigator.of(context).pop();
            await Provider.of<Service>(context, listen: false).auth.signOut();
          },
          child: Text('Log Out', style: textTheme.bodyText1),
        ),
      ),
    );
  }

  Widget _buldProfile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            user.Name,
            style: textTheme.headline1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            user.role,
            style: textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
