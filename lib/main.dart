import 'package:flutter/material.dart';

void main() => runApp(const ColorFilterApp());

class ColorFilterApp extends StatelessWidget {
  const ColorFilterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FilterSimulatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FilterSimulatorScreen extends StatefulWidget {
  const FilterSimulatorScreen({Key? key}) : super(key: key);

  @override
  _FilterSimulatorScreenState createState() => _FilterSimulatorScreenState();
}

class _FilterSimulatorScreenState extends State<FilterSimulatorScreen> {
  bool isFilterActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Mô Phỏng Bộ Lọc Màu Xanh'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'VẬT THỂ MÔ PHỎNG TRƯỚC CAMERA',
                  style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 2),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Lớp 1: Khối màu ĐỎ nằm ở dưới cùng
                      Container(
                        width: 150,
                        height: 150,
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: const Text('MÀU ĐỎ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      
                      // Lớp 2: Khối màu ĐEN nằm góc dưới
                      Positioned(
                        bottom: 40,
                        child: Container(
                          width: 80,
                          height: 40,
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: const Text('MÀU ĐEN', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),

                      // Lớp 3: TẤM CHẮN XANH LÁ phủ lên trên (Áp dụng bộ lọc ma trận màu để khử màu xanh)
                      ColorFiltered(
                        colorFilter: isFilterActive
                            ? const ColorFilter.matrix(<double>[
                                0.2, 0.2, 0.2, 0, 0, // Dòng xử lý sắc đỏ
                                0.0, 0.0, 0.0, 0, 0, // Khử hoàn toàn sắc xanh lá (Gốc g = 0)
                                0.2, 0.2, 0.2, 0, 0, // Dòng xử lý sắc xanh dương
                                0.0, 0.0, 0.0, 0.3, 0, // Giảm độ đậm (Alpha) để nhìn xuyên thấu qua tấm chắn
                              ])
                            : const ColorFilter.matrix(<double>[
                                1, 0, 0, 0, 0,
                                0, 1, 0, 0, 0,
                                0, 0, 1, 0, 0,
                                0, 0, 0, 1, 0,
                              ]),
                        child: Container(
                          width: 260,
                          height: 260,
                          color: Colors.green.withOpacity(0.9), 
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text('TẤM CHẮN XANH LÁ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Thanh gạt Bật/Tắt bộ lọc phía dưới màn hình
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bộ lọc khử Xanh (Nhìn xuyên):',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  Switch(
                    value: isFilterActive,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        isFilterActive = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
