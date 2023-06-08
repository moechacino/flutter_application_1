import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'senin_admin.dart';
import 'selasa_admin.dart';
import 'rabu_admin.dart';
import 'kamis_admin.dart';
import 'jumat_admin.dart';
import 'sabtu_admin.dart';
import 'minggu_admin.dart';

class SevenButtonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SeninButton(),
          SizedBox(height: 20),
          SelasaButton(),
          SizedBox(height: 20),
          RabuButton(),
          SizedBox(height: 20),
          KamisButton(),
          SizedBox(height: 20),
          JumatButton(),
          SizedBox(height: 20),
          SabtuButton(),
          SizedBox(height: 20),
          MingguButton(),
        ],
      ),
    );
  }
}

class SeninButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SeninScreen()),
          );
        },
        child: Text('SENIN'),
      ),
    );
  }
}

class SelasaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelasaScreen()),
          );
        },
        child: Text('SELASA'),
      ),
    );
  }
}

class RabuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RabuScreen()),
          );
        },
        child: Text('RABU'),
      ),
    );
  }
}

class KamisButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KamisScreen()),
          );
        },
        child: Text('KAMIS'),
      ),
    );
  }
}

class JumatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JumatScreen()),
          );
        },
        child: Text('JUMAT'),
      ),
    );
  }
}

class SabtuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SabtuScreen()),
          );
        },
        child: Text('SABTU'),
      ),
    );
  }
}

class MingguButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MingguScreen()),
          );
        },
        child: Text('MINGGU'),
      ),
    );
  }
}
