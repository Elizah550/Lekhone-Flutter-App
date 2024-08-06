import 'package:flutter/material.dart';
import 'package:Lekhone/screens/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  static String routeName = 'App';

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lekhone',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 26, 193, 46),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
        unselectedWidgetColor: const Color(0x50333333),
        shadowColor: const Color(0xFFe6e6e6).withOpacity(0.5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            color: const Color(0xFF111111),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.poppins(
            color: const Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: GoogleFonts.poppins(
            color: const Color(0xFF111111),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.poppins(
            color: const Color(0xFF111111),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: GoogleFonts.poppins(
            color: const Color(0xFF111111),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: GoogleFonts.poppins(
            color: Theme.of(context).unselectedWidgetColor,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: const Color(0xFF111111),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(background: Colors.white),
      ),
      home: const Apps(),
    );
  }
}

class Apps extends StatefulWidget {
  const Apps({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Apps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              child: Text(
                'Track parcel',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            centerTitle: false,
            floating: true,
            snap: false,
            pinned: true,
            titleSpacing: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                        'https://miro.medium.com/fit/c/1360/1360/2*NDZrabY3uLA-1MM3K1MexQ.png'),
                  ),
                ),
              ),
            ],
            shadowColor: Colors.transparent,
            expandedHeight: 326,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 64,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter parcel number or scan QR code',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 7,
                              bottom: 40,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 49,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  width: 50,
                                  height: 49,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/icon_qrcode.svg',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Track parcel',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              style: Theme.of(context).textButtonTheme.style,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(
              top: 32,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My parcels',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              )
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Container(
                  height: 174,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '00359007738060313786',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Container(
                            height: 31,
                            width: 78,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/1000px-Amazon_logo.svg.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'In transit',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Last update: 3 hours ago',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.5),
                              child: LinearProgressIndicator(
                                value: 0.7,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                backgroundColor: const Color(0xFFF8F8F8),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 60,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Details',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SvgPicture.asset(
                                    'assets/images/icon_details.svg')
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
