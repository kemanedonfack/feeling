import 'package:flutter/material.dart';

class ModifierInformation extends StatefulWidget {
  const ModifierInformation({Key? key}) : super(key: key);


  @override
  _ModifierInformationState createState() => _ModifierInformationState();
}

class _ModifierInformationState extends State<ModifierInformation> {

    
  final _formKey = GlobalKey<FormState>();

  String sex="";

  TextEditingController nomcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController villecontroller = TextEditingController();
  
  List<String> villes = ["Douala", "Yaoundé", "Bamenda", "Buéa", "Ngaoundére", "Garoua", "Maroua"];
  String? ville;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Mes informations", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor)
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
              
                  TextFormField(
                    controller: nomcontroller,
                    decoration: InputDecoration(
                    hintText: "Entrer votre nom d'utilisateur",
                    prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                        return "Veuillez entrer votre nom";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: agecontroller,
                    decoration: InputDecoration(
                      hintText: 'votre age',
                      prefixIcon: Icon(Icons.date_range, color:  Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                          return "Veuillez entrer votre âge";
                        }else{
                          return null;
                        }
                      },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  TextFormField(
                    controller: nomcontroller,
                    decoration: InputDecoration(
                    hintText: "Entrer votre Profession",
                    prefixIcon: Icon(Icons.work, color: Theme.of(context).primaryColor,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                        return "Veuillez entrer votre Profession";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: ville == null ? const Text("Choississez la ville") : Text(ville!) ,
                        underline: const SizedBox(),
                        items: villes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState((){
                            ville = value as String?; 
                          });
                        },
                      ),
                    )
                  ),
            
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {  },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Enregistrer",
                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                    
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}