import 'package:bluecolorguy/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Homeviews extends StatefulWidget {
  const Homeviews({super.key});

  @override
  State<Homeviews> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeviews> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final size = MediaQuery.of(context).size;
    // const url = "https://www.google.com/";
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 110,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Portal",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Container(
                  // color: Colors.green,
                  child: const Image(
                    height: 70,
                    image: AssetImage('assets/images/logo.png'),
                    // child: const Text("data")
                  ),
                ),
                Material(
                  color: const Color.fromARGB(255, 55, 54, 54),
                  borderRadius: BorderRadius.circular(10),
                  child: IconButton(
                    color: Colors.blue,
                    icon: const Icon(
                      size: 32,
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    onPressed: (() {
                      authService.SignOut();
                    }),
                  ),
                ),
              ],
            ),
          ),
          Link(
            target: LinkTarget.defaultTarget,
            uri: Uri.parse("https://myprofreelancer.com/"),
            builder: (context, followLink) => InkWell(
              onTap: followLink,
              child: Stack(
                children: [
                  Container(
                    height: size.height / 12,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 35),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/myprofreelancer-Logo.png'),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 10,
                    top: 8,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Link(
            target: LinkTarget.defaultTarget,
            uri: Uri.parse("https://bluecollarguy.ca/"),
            builder: (context, followLink) => InkWell(
              onTap: followLink,
              child: Row(
                children: [
                  Container(
                    height: size.height / 12,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 38, 34, 34),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Image(
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                        Text(
                          "Check Latest Deals",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Container(
          //   height: size.height / 12,
          //   width: size.width,
          //   decoration: const BoxDecoration(
          //     color: Color.fromARGB(255, 35, 35, 35),
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/myprofreelancer-Logo.png'),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Link(
          //         target: LinkTarget.defaultTarget,
          //         uri: Uri.parse("https://myprofreelancer.com/"),
          //         builder: (context, followLink) => InkWell(
          //           onTap: followLink,
          //           child: const Text('Open Link'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            child: Center(
              child: Link(
                target: LinkTarget.defaultTarget,
                uri: Uri.parse("https://bluecollarguy.ca/"),
                builder: (context, followLink) => InkWell(
                  onTap: followLink,
                  child: const Text('Open Link'),
                ),
              ),
            ),
          ),

          // TextButton(
          //   onPressed: () async {
          //     const url = "https://bluecollarguy.ca/";
          //     if (await launchUrl(
          //       Uri.parse(url),
          //     )) {
          //       await canLaunchUrl(Uri.parse(url));
          //     } else {
          //       throw 'Could not launch $url';
          //     }
          //   },
          //   child: const Text(
          //     'Open a URL',
          //   ),
          // ),

          // Link(
          //     uri: Uri.parse("https://flutter.dev"),
          //     builder: (BuildContext context, followLink) => ElevatedButton(
          //           child: Text('iasfsbcz'),
          //           onPressed: followLink,
          //           // ... other properties here ...
          //         )),

          Expanded(
            child: Card(
              elevation: 10,
              color: Colors.green,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: const [
                  Card(
                      child: ListTile(
                          title: Text("Dr. Devid Jons"),
                          subtitle: Text("www.media.com"),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                          trailing: Icon(Icons.open_in_new))),
                  Card(
                      child: ListTile(
                          title: Text("Lawyer"),
                          subtitle: Text("Lower the anchor."),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                          trailing: Icon(Icons.open_in_new))),
                  Card(
                      child: ListTile(
                          title: Text("Alarm"),
                          subtitle: Text("This is the time."),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                          trailing: Icon(Icons.open_in_new))),
                  Card(
                      child: ListTile(
                          title: Text("Ballot"),
                          subtitle: Text("Cast your vote."),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                          trailing: Icon(Icons.open_in_new)))
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.facebook,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("This is the name of title"),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              // cursorHeight: 10,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "Past you Url",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
        },
        child: const Icon(
          Icons.add_circle,
          size: 34,
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        elevation: 10,
        backgroundColor: Colors.green,
        width: size.width / 2,
        child: const Text("data"),
      ),
    );
  }
}
