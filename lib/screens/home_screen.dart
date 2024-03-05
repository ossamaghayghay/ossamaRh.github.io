import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111E41),
      body: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Container(
            width: 600,
            margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Oussama Rhayrhay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                Text(
                  'Flutter Developer (FullStack)',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    '''As a self-taught Flutter developer, I bring one year of hands-on experience in crafting mobile applications with a focus on cross-platform development. My journey into the world of Flutter has equipped me with a diverse skill set, blending creativity with technical proficiency. Throughout my experience, I've actively contributed to the development of Flutter applications, demonstrating a keen understanding of Dart programming language and Flutter framework. I've successfully translated design concepts into efficient and user-friendly mobile interfaces, ensuring a seamless and engaging user experience. My commitment to staying current with industry trends and continuous learning has allowed me to adapt to evolving technologies. I approach challenges with a problem-solving mindset, and my dedication to delivering high-quality software reflects my passion for creating impactful and innovative solutions. I am eager to further enhance my skills and contribute to projects that leverage my expertise in Flutter development. As I continue my journey, I am enthusiastic about embracing new challenges and collaborating with dynamic teams to build cutting-edge mobile applications.''',
                    style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 600,
            margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(8.0),
            child: Flexible(
              child: ListView.builder(
                itemCount: 10, // Specify the number of items
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
