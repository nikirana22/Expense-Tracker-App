import 'package:flutter/material.dart';
import '/widgets/spending_graph.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 230,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Spanding',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: CustomPaint(
                          painter: SpendingGraph(circleRadius: 20))),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Spending',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                return const ListTile(
                  tileColor: Colors.grey,
                  title: Text(
                    'Buy Coffee',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Shoping '),
                  trailing: Text(
                    '\$10',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox(height: 10);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
