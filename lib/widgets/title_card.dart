import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget titleCard(BuildContext context, String label, String routeName) {
  return GestureDetector(
    onTap: () {
      context.push(routeName);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Color(0xFFFDB741), width: 1.5), // Add a yellow outline
        color: Colors.white, // Change background color to white
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            color: Colors.black,
          )
        ],
      ),
    ),
  );
}
