import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showMessageDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
    ),
  );
}

showNotVerifiedDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(24),
        icon: Icon(
          Icons.info_rounded,
          size: 70,
          color: Colors.orange[700],
        ),
        content: Text(
          "You have not been approved to login, please wait until you will get approved",
          style: GoogleFonts.poppins(),
          textAlign: TextAlign.center,
        ),
      ),
    );
