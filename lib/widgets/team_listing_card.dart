import 'package:flutter/material.dart';
import 'package:nms/utils/theme/theme.dart';

class TeamListingCard extends StatelessWidget {
  const TeamListingCard({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueGrey,
                        backgroundImage: AssetImage('assets/png/person.jpg')),
                    title: Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    subtitle: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Full Stack Developer',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: hintColor),
                        ),
                        Text(
                          'Tech Team',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: hintColor),
                        )
                      ],
                    ),

                    // trailing: ,
                  ),
                ),
                Image.asset('assets/png/arrow_right.png')
              ],
            ),
            const Divider(
              color: replyMessageColor,
            )
          ],
        ),
      ),
    );
  }
}
