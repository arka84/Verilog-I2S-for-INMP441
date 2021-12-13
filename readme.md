This project is about I2S bus. This project use chip INMP441. INMP441 connects with FPGA using I2S. INMP441 is omnidirectional microphone with I2S didgital output.
In this project we have 2 clock output: SDK and WS. Frequency of WS is 48 kHz and frequency of SCK is fws *64 = 3.125 Mhz (This requirement set in specification for INMP441).
In this project we have input CLOCK_50, becouse our FPGA has external clock signal from oscillator. Frequency of oscillator is 50 mHz.
In this project we have tri-state output SD. SD is serial-data output.
