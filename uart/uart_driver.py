import serial
import time

class UARTDriver:
    def __init__(self, port="/dev/ttyUSB0", baud=115200, timeout=1):
        self.ser = serial.Serial(port, baud, timeout=timeout)
        time.sleep(2)

    def send_byte(self, val: int):
        self.ser.write(bytes([val & 0xFF]))
        time.sleep(0.001)

    def read_byte(self):
        b = self.ser.read(1)
        return b[0] if b else None

    def close(self):
        self.ser.close()

