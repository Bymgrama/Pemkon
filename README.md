# ASEP-STM32: Adaptive Safety-Embedded Programming

## Project Description
ASEP-STM32 is a novel lightweight baremetal framework for STM32 microcontrollers that integrates Adaptive PID-lite control with hardware-level safety mechanisms. Developed as a synthesis of 15 recent academic papers, it addresses the need for real-time determinism, ultra-low latency, and embedded anomaly protection (safety shutdown) without the heavy overhead of RTOS or Machine Learning algorithms.

## Flowchart & Architecture
The system utilizes continuous polling of environmental sensors via ADC. It calculates real-time variance to determine the operating mode:
- **Normal Mode:** Steady state, optimal PID control.
- **Warning Mode:** Mild fluctuations, adaptive PID parameters applied.
- **Critical Mode:** Extreme anomalies trigger immediate Safety Shutdown (PWM = 0) and watchdog monitoring.

## How to Run the Simulation
1. **STM32CubeMX:** Open the .ioc file to generate the initialization code for STM32F401VE.
2. **Keil uVision:** Open the project, compile the C/C++ code (press F7 to Rebuild All), and generate the .hex file.
3. **Proteus 8:** Open the simulation schematic. Double-click the STM32 component, load the .hex file, and press Play. Use RV1 (Potentiometer) to simulate sensor variance.

## Simulation Results
The simulation data (voltage, adaptive PWM duty cycle, and UART throughput) were logged and plotted using **GNUPlot**. 
*(Insert grafik_asep.png here)*
The GNUPlot results clearly demonstrate the system's ability to smoothly transition between Normal, Warning, and Critical states in real-time, effectively protecting the simulated actuator.

## Advantages of ASEP-STM32
- **Ultra-Lightweight:** Minimal RAM usage and microsecond execution time.
- **Resilient Safety:** Built-in Stack Sentinel and Independent Watchdog (IWDG) prevent hard faults.
- **Real-Time Determinism:** Baremetal execution guarantees jitter-free performance compared to traditional RTOS approaches.