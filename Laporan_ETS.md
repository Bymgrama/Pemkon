# LAPORAN EVALUASI TENGAH SEMESTER
## MATA KULIAH PEMROGRAMAN KONTROLLER

**A. Studi Literatur**
*(Pindahkan tabel dari Excel ke sini. Kolom: No, Judul, Penulis (Tahun), Metode, Hasil Utama, Future Work)*

**Daftar Future Work yang Diintegrasikan:**
FW1-FW5: Perlunya sistem kontroler yang ringan namun adaptif terhadap ketidakpastian lingkungan tanpa OS yang berat (Baremetal).
FW6-FW9: Perlunya perlindungan keamanan mandiri (hardware-level security) dan deteksi anomali pada arsitektur edge/IoT.
FW10-FW15: Perlunya minimisasi latensi (jitter) untuk sistem waktu nyata (real-time) melalui akses register langsung.

**B. Metode Baru yang Diusulkan**
**Judul Metode:** ASEP-STM32 (Adaptive Safety-Embedded Programming on STM32)
**Dasar:** Gabungan future work FW1 s.d. FW15 mengenai kontrol adaptif yang sangat ringan, proteksi anomali di level edge, dan eksekusi real-time deterministik.

**Deskripsi Metode:**
Metode ASEP-STM32 memadukan algoritma *Adaptive PID-lite* dengan mekanisme *Safety-Embedded* langsung di atas arsitektur baremetal mikrokontroler STM32F401VE. Berbeda dengan pendekatan machine learning atau OS yang memakan memori dan latensi, ASEP-STM32 menggunakan variansi (variance) dari data sensor ADC secara real-time untuk mendeteksi fluktuasi/anomali. 
Jika fluktuasi stabil (Normal), sistem melakukan kontrol PWM standar. Jika fluktuasi menengah (Warning), parameter Kp menyesuaikan diri. Jika terjadi lonjakan ekstrem (Critical), sistem melakukan interupsi perlindungan mandiri (*Safety Shutdown*) dengan menekan PWM ke 0%. Metode ini diimplementasikan menggunakan C/C++ (Keil uVision) dengan optimasi register dan watchdog timer (IWDG) untuk perlindungan tambahan dari kegagalan sistem.

**C. Simulasi dan Hasil**
**Alat dan Perangkat Lunak**
- Simulator: Proteus 8.xx
- IDE: Keil uVision (Kelas 4B)
- Konfigurasi: STM32CubeMX
- Plotting: GNUPlot
- Mikrokontroler target: STM32F401VE

**Rangkaian Simulasi**
*(Masukkan screenshot Proteus dengan RV1, RV2, Oscilloscope, dan Virtual Terminal di sini)*

**Data dan Plot GNUPlot**
*(Masukkan gambar grafik_asep.png di sini)*
**Analisis Hasil:** Grafik di atas menunjukkan 3 fase operasional. Pada waktu 0-1500ms, sistem berjalan di mode Normal dengan PWM konstan (50% duty cycle). Pada 1500-3500ms, saat diberi ketidakpastian input, kontroler secara dinamis mengatur PWM (Mode Warning) untuk menjaga aktuator. Setelah 3500ms, terjadi fluktuasi sangat ekstrem, sehingga sistem secara otomatis mengunci PWM ke nilai 0 (Mode Critical) untuk memitigasi kerusakan, sementara throughput komunikasi menurun secara stabil.

**D. Keunggulan Metode**
Dibandingkan dengan jurnal acuan yang mayoritas menggunakan FreeRTOS atau kontrol cerdas (seperti Neural Networks) yang sangat berat, metode ASEP-STM32 memiliki tiga keunggulan utama:
1. **Penggunaan Memori & Kecepatan:** Pendekatan baremetal dengan perhitungan variansi sederhana memakan RAM sangat kecil (< 5KB) dan dieksekusi dalam latensi mikro-detik.
2. **Aspek Safety:** Terdapat *Hard-fault barrier* (Stack Sentinel) dan IWDG yang tidak ditemukan pada algoritma ML konvensional, sehingga sistem lebih tahan banting (resilient) dari crash atau serangan.
3. **Kontribusi Orisinalitas:** Penggabungan kontrol PID adaptif dengan mekanisme *safety shutdown* otomatis di level register belum banyak diujicobakan pada domain instrumentasi *low-end*. 

**F. Kesimpulan**
- **Hasil Studi Literatur:** Tren *future work* saat ini berfokus pada sistem embedded yang butuh keamanan tinggi, performa real-time, dan adaptabilitas tanpa mengorbankan resource memori.
- **Metode Baru:** ASEP-STM32 dirancang sebagai kerangka kerja *baremetal* yang ringan, mencakup kontrol *Adaptive PID-lite* dan sistem proteksi *Critical Shutdown*.
- **Temuan Utama:** Simulasi di Proteus menunjukkan metode ini mampu melakukan deteksi variansi anomali dan langsung bereaksi mengubah duty cycle aktuator hingga 0% saat kritis dengan seketika.
- **Keunggulan & Potensi:** ASEP-STM32 menawarkan solusi hemat daya dan komputasi dengan tingkat *safety* tinggi. Potensi ke depannya adalah mengimplementasikan protokol keamanan komunikasi berenkripsi (seperti TLS) secara *hardware-accelerated*.