cd 'C:\Users\DELL\P1_pemkon\ASEP_F401'
set terminal pngcairo size 1200,900 enhanced font 'Segoe UI,12' background '#ffffff'
set output 'grafik_asep.png'

# Modern color palette (Material Design)
color_voltage = '#2196F3' # Blue
color_pwm = '#F44336'     # Red
color_thr = '#4CAF50'     # Green
color_grid = '#E0E0E0'
color_text = '#333333'
color_border = '#9E9E9E'

# Global styling
set multiplot layout 3,1 title 'ASEP-STM32 Adaptive Safety Performance Analysis' font 'Segoe UI Bold,18' tc rgb color_text
set datafile separator ','

# Clean grid and minimalist borders (left and bottom only)
set border 3 lw 1.5 lc rgb color_border
set grid ytics lc rgb color_grid lw 1 dt 3
set grid xtics lc rgb color_grid lw 1 dt 3
set tics nomirror tc rgb color_text

# Margins for clean layout spacing
set lmargin 12
set rmargin 8
set tmargin 2
set bmargin 2

# Key/Legend styling
set key outside top right font 'Segoe UI,11' textcolor rgb color_text opaque box lc rgb '#ffffff' lw 0

# ==========================================
# Plot 1: Sensor Voltage
# ==========================================
set title 'Sensor Voltage (PA0)' font 'Segoe UI Semibold,14' tc rgb color_text offset 0, -0.5
set ylabel 'Voltage (mV)' font 'Segoe UI,12' tc rgb color_text offset -1,0
set yrange [0:3500]
set ytics 1000

# Plot with area fill for modern look
plot 'sim_data.csv' every ::1 using 1:2 with filledcurves y1=0 fs solid 0.1 noborder lc rgb color_voltage notitle, \
     '' every ::1 using 1:2 with lines lw 2.5 lc rgb color_voltage title 'Tegangan Aktual'

# ==========================================
# Plot 2: PWM Duty Cycle Adaptive Response
# ==========================================
set title 'Adaptive PWM Duty Cycle (Protective Action)' font 'Segoe UI Semibold,14' tc rgb color_text offset 0, -0.5
set ylabel 'Duty (0-999)' font 'Segoe UI,12' tc rgb color_text offset -1,0
set yrange [-50:1100]
set ytics 250

plot 'sim_data.csv' every ::1 using 1:3 with filledcurves y1=0 fs solid 0.1 noborder lc rgb color_pwm notitle, \
     '' every ::1 using 1:3 with lines lw 2.5 lc rgb color_pwm title 'Output PWM'

# ==========================================
# Plot 3: UART Throughput
# ==========================================
set title 'UART Communication Throughput' font 'Segoe UI Semibold,14' tc rgb color_text offset 0, -0.5
set xlabel 'Time (ms)' font 'Segoe UI Bold,12' tc rgb color_text offset 0,-0.5
set ylabel 'Throughput (Bps)' font 'Segoe UI,12' tc rgb color_text offset -1,0
set yrange [0:1300]
set ytics 400
set bmargin 5

plot 'sim_data.csv' every ::1 using 1:5 with filledcurves y1=0 fs solid 0.1 noborder lc rgb color_thr notitle, \
     '' every ::1 using 1:5 with lines lw 2.5 lc rgb color_thr title 'Bandwidth (Bytes/s)'

unset multiplot