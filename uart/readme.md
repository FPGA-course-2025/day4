# UART exercise

In this exercise we will connect the UART module from day 3 to an HLS module that accumulates the received value and transmits the accumulated value.

## FPGA Design

A partial design is provided for you integrating the HLS accumulator module with the UART RX/TX from Day 3.
You will need to complete the `top.vhd` instantiation of the accumulator to correctly drive the various modules and the control ports, find the entity at the end of the `top.vhd` file.

<img src="https://docs.amd.com/api/khub/maps/wsGrDyp6~9qclJFHVNa2XQ/resources/3VRYInJaiVzwWZEiCer3eg-wsGrDyp6~9qclJFHVNa2XQ/resized-content?v=55f7ea60f5573ec9&Ft-Calling-App=ft/turnkey-portal" width="400" />

- Run C Synthesis of the HLS design `vitis_hls -f csynth.tcl`
- Create a new Vivado project targeting the Arty 100T board as in previous days:
    - Add the VHDL from `AccumulatorProj/solution1/syn/vhdl/`
    - Add the VHDL from `VHDL/`
        - Including your corrected `top.vhd`
    - Add the constraints `Arty-A7-100-Master.xdc`
- Run behavioral simulation to validate your integration
- Run Synthesis, Implementation, Generate Bitstream
    - Make sure that the `testbench.vhd` is not the top level file for synthesis
- Program the device with the bitstream

## Runtime

A simple Python driver is provided to test the design. You might need to `pip install pyserial` first.
Send different values and watch the accumulator increase if you connected it correctly!

**Note**: at the time of writing, the output of the design seems to be slightly wrong!
Instead of transmitting `x0 + x1 + x2 + x3 + x4` after writing the fifth byte, the device seems to send `x0 + x1 + x2 + x3 + x4 + x4`.
In other words the final value is dobule counted! It implies that the internal state is correct, but who knows what's gone wrong.
This is also a very real world example...
Bonus points to anybody who can fix it.

```
import uart_driver
device = uart_driver.UARTDriver()
device.send_byte(0)
device.read_byte()
```
