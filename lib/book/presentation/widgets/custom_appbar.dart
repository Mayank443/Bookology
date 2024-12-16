import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final ValueChanged<String>? onSearchChanged;

  const CustomAppBar({
    super.key,
    required this.searchController,
    this.onSearchChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Image(image: AssetImage('assets/Images/bl01.png')),
      title: isSearching
          ? TextField(
              controller: widget.searchController,
              cursorColor: Colors.black,
              style: const TextStyle(height: 1.0),
              decoration: InputDecoration(
                hintText: 'Search by title, author...',
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromRGBO(255, 252, 208, .85),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                suffixIcon: widget.searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.black),
                        onPressed: () {
                          widget.searchController.clear();
                          widget.onSearchChanged?.call('');
                        },
                      )
                    : null,
                enabledBorder: _buildBorder(Colors.black, 2.0),
                focusedBorder: _buildBorder(Colors.black, 1.5),
              ),
              onChanged: widget.onSearchChanged,
            )
          : Text(
              'Bookology',
              style: GoogleFonts.oldenburg(
                textStyle: const TextStyle(
                  color: Color.fromRGBO(255, 252, 208, 1),
                  fontSize: 26,
                ),
              ),
            ),
      flexibleSpace: const Image(
        image: AssetImage("assets/Images/leather.jpg"),
        fit: BoxFit.cover,
      ),
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.home : Icons.search),
          color: const Color.fromRGBO(255, 252, 208, 1),
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
              if (!isSearching) {
                widget.searchController.clear();
                widget.onSearchChanged?.call('');
              }
            });
          },
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}