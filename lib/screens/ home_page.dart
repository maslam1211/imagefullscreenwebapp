import 'package:flutter/material.dart';
import 'package:image_resolution/servies/fullscreen_service.dart';
import '../widgets/url_input_field.dart';
import '../widgets/image_viewer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _urlController = TextEditingController();
  String imageUrl = '';
  bool isMenuOpen = false;
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadImage() async {
    setState(() {
      isLoading = true;
      imageUrl = _urlController.text;
    });

    await Future.delayed(const Duration(milliseconds: 500)); 

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isMenuOpen) setState(() => isMenuOpen = false);
      },
      child: Scaffold(
        backgroundColor: isMenuOpen ? Colors.black.withOpacity(0.4) : Colors.grey[50],
        appBar: AppBar(
          title: const Text('Image Fullscreen Web App'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 3,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: UrlInputField(
                        controller: _urlController,
                        onShowImage: _loadImage,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ImageViewer(
                              imageUrl: imageUrl,
                              onDoubleTap: FullscreenService.toggleFullscreen,
                            ),
                            if (isLoading)
                              const CircularProgressIndicator(
                                color: Colors.deepPurpleAccent,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizeTransition(
                    sizeFactor: _animation,
                    axisAlignment: -1.0,
                    child: Column(
                      children: [
                        _buildMenuButton('Enter Fullscreen', FullscreenService.enterFullscreen),
                        const SizedBox(height: 12),
                        _buildMenuButton('Exit Fullscreen', FullscreenService.exitFullscreen),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.deepPurpleAccent,
                    onPressed: () {
                      setState(() => isMenuOpen = !isMenuOpen);
                      isMenuOpen ? _animationController.forward() : _animationController.reverse();
                    },
                    child: Icon(isMenuOpen ? Icons.close : Icons.more_vert),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildMenuButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        elevation: 6,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () {
        onPressed();
        setState(() => isMenuOpen = false);
        _animationController.reverse();
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}