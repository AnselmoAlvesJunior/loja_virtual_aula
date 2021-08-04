import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,

        ),
        body:ScopedModelDescendant<UserModel>(
            builder: (context,child,model){
              if(model.isLoading)
                return Center(child: CircularProgressIndicator(),);

              return Form(

                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: "Nome Completo"
                      ),
                      validator: (text){
                        if(text.isEmpty ) return "Nome inválido!";

                      },
                    ),
                    SizedBox(height: 16.0,),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "E-mail"
                      ),
                      validator: (text){
                        if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";

                      },
                      keyboardType: TextInputType.emailAddress ,
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Senha"
                      ),
                      validator: (text){
                        if(text.isEmpty|| text.length<6) return "Senha inválida";
                      },
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                          hintText: "Endereço"
                      ),
                      validator: (text){
                        if(text.isEmpty) return "Endereço inválido";
                      },
                    ),
                    SizedBox(height: 16.0,),
                    SizedBox(
                      height: 44.0,
                      child: ElevatedButton(onPressed: (){
                        if(_formKey.currentState.validate()){
                          Map<String,dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text
                          };
                          model.signUp(userData: userData, pass: _passwordController.text, onSuccess: _onSuccess, onFail: _onFail);
                        }
                      },
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary:  Theme.of(context).primaryColor,
                            onPrimary: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        )
    );
  }
  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usúario criado com sucesso!!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }
  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Erro ao criar usúario!!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

}

