import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';

class ProfileDetailScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  ProfileDetailScreen(this.utilisateurs);

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height*0.6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.utilisateurs.photo[0]),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    margin: EdgeInsets.only(top: size.height*0.57),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${widget.utilisateurs.nom}, ${widget.utilisateurs.age}", style: TextStyle(fontSize: size.width*0.06, fontWeight: FontWeight.bold),),
                                  Text("${widget.utilisateurs.profession}", style: TextStyle(fontSize: size.width*0.04, color:Colors.grey, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Icon(Icons.share, color: Theme.of(context).primaryColor, size: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height*0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Localisation", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                                  Text("${widget.utilisateurs.ville}, ${widget.utilisateurs.pays}", style: TextStyle(fontSize: size.width*0.04, color:Colors.grey, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor, size: size.width*0.04,),
                                    Text("1 km", style: TextStyle(fontSize: size.width*0.04, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height*0.025),
                          Text("A propos", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                          SizedBox(height: size.height*0.015),
                          Text("${widget.utilisateurs.propos}", textAlign: TextAlign.justify),
                          
                          SizedBox(height: size.height*0.03),
                          Text("Centre d'intérêt", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                          SizedBox(height: size.height*0.02),
                          Row(
                            children: [
                              for(int i=0; i<widget.utilisateurs.interet.length; i++)
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text("${widget.utilisateurs.interet[i]}", style: TextStyle(fontSize: size.width*0.04, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor, width: 1, style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: size.height*0.03),
                          Text("Gallerie", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                          SizedBox(height: size.height*0.02),
                        ],
                      ),
                    ),
                  ),
                  
      
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




