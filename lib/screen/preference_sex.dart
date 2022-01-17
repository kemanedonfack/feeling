import 'package:flutter/material.dart';

class PreferenceSexScreen extends StatefulWidget {

  @override
  _PreferenceSexScreenState createState() => _PreferenceSexScreenState();
}

class _PreferenceSexScreenState extends State<PreferenceSexScreen> {

  String preference="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                  ),
                  child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.width*0.06),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.1),
              Text("Je préfère", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.05)
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.1),

              InkWell(
                onTap: (){
                    select("Homme");
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: preference.contains("Homme") ? Theme.of(context).primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: preference.contains("Homme") ? null : Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Homme", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, color: preference.contains("Homme") ? Colors.white : Colors.black)),
                      Icon(Icons.check, color: preference.contains("Homme") ? Colors.white : Colors.black)
                    ],
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.04),
              InkWell(
                onTap: (){
                    select("Femme");
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: preference.contains("Femme") ? Theme.of(context).primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: preference.contains("Femme") ? null : Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Femme", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, color: preference.contains("Femme") ? Colors.white : Colors.black)),
                      Icon(Icons.check, color: preference.contains("Femme") ? Colors.white : Colors.black)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: InkWell(
          
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).primaryColor ,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {   },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Continue",
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  void select(String sexe) {
    if(!preference.contains(sexe)){
      setState(() {
        preference=sexe;
      });
    }else{
      setState(() {
        preference=sexe;
      });
    }
  }


}


