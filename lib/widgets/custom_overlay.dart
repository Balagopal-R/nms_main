import 'package:flutter/material.dart';
import 'package:nms/utils/theme/theme.dart';
 
class CustomOverlay {
  static OverlayEntry createOverlayEntry(BuildContext context,
      {required VoidCallback yesCallback,
      required VoidCallback closeCallback,
      required int color,
      required String text,
      required double height,
      required String firstButtontext,
     
      }) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          ModalBarrier(
            color: Colors.black.withOpacity(0.1), // Adjust opacity as needed
            dismissible: false, // Prevents dismissing by tapping outside
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                // height: MediaQuery.of(context).size.height * 0.25,
                height: height,
                child: AlertDialog(
                  elevation: 2.0,
                  backgroundColor: const Color(0xff1D1D1D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: backgroundColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: yesCallback,
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(color),
                            borderRadius: BorderRadius.circular(3.0),
                            border: Border.all(
                              color: Color(color),
                              width: 2.0,
                            ),
                          ),
                          child:  Center(
                            child: Text(
                              firstButtontext,
                              style: const TextStyle(color: backgroundColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: closeCallback,
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            border: Border.all(
                              color: Color(color),
                              width: 2.0,
                            ),
                          ),
                          child: const Center(
                            child: Text("Cancel",
                                style: TextStyle(color: backgroundColor)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}