import 'package:flutter/material.dart';
import 'package:ronkhlab_agro/authantification/seconnnecter.dart';
import 'package:ronkhlab_agro/database_sqlite/bd_sqlite.dart';
import 'package:ronkhlab_agro/models/user_model.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  bool isvisible = false;
  bool ischecked = false;

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'RonkhLab Agro',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Créer  Votre Compte !',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Inscrivez-vous dès maintenant !',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  ),
                ),
                //Nom d'utilisateur
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsetsGeometry.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nom d'utilisateur",
                      border: InputBorder.none,
                      icon: Icon(Icons.person_2),
                    ),
                  ),
                ),

                //Nom d'utilisateur mot de passse
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsetsGeometry.all(8),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },

                    obscureText: isvisible,
                    decoration: InputDecoration(
                      hintText: "Passeword",
                      border: InputBorder.none,
                      icon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        icon: Icon(
                          isvisible ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ),
                //confirmation de mot de passe
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsetsGeometry.all(8),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: TextFormField(
                    controller: confirmpassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "confirmpassword is required";
                      } else if (password.text != confirmpassword.text) {
                        return "Password don't match";
                      }
                      return null;
                    },

                    obscureText: isvisible,
                    decoration: InputDecoration(
                      hintText: "Passeword",
                      border: InputBorder.none,
                      icon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        icon: Icon(
                          isvisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                ListTile(
                  leading: Checkbox(
                    value: ischecked,
                    onChanged: (bool? value) {
                      setState(() {
                        ischecked = value ?? false;
                      });
                    },
                  ),

                  title: Text(
                    "J'accepte les CGU et politique de confidentialités.",
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                Container(
                  height: 54,
                  width: double.infinity,
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Colors.blueGrey, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (!ischecked) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Vous devez accepter les conditions.",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return; // stop ici
                      }
                      if (formkey.currentState!.validate() && ischecked) {
                        final db = UserDb();
                        db
                            .signup(
                              Users(
                                usrName: username.text,
                                usrPassword: password.text,
                                id: null,
                                VALUES: null,
                              ),
                            )
                            .whenComplete(() {
                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            });
                      }
                    },
                    child: Text(
                      "Créer Mon Compte",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous avez déjà un compte !"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text("Se Connecter"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
