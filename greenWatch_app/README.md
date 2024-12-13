# GreenWatch App

**GreenWatch** is a Flutter application that allows users to monitor the conditions of their greenhouse remotely. With the help of the **ESP8266 module**, which is connected to Wi-Fi, the app displays real-time data about:

- **Temperature**
- **Humidity**
- **Soil Humidity**
- **Luminosity**

Additionally, **GreenWatch** includes a **shop** feature where users can browse and purchase agricultural products needed for greenhouse management.

## Getting Started

For the complete setup and prerequisites, please refer to the [Flutter_Apps README](https://github.com/yourusername/Flutter_Apps/blob/main/README.md), as it covers everything you need to know about setting up Flutter, installing dependencies, and running the app.

This project consists of two main components:

1. **GreenWatch Flutter App** - The mobile app to monitor greenhouse conditions and shop for agricultural products.
2. **ESP8266 Code** - Code for the ESP8266 module that connects to Wi-Fi and sends sensor data.

### Setting Up the ESP8266

1. **Install the Arduino IDE**  
   If you don’t have the Arduino IDE, download and install it from [here](https://www.arduino.cc/en/software).

2. **Install ESP8266 Board in Arduino IDE**  
   Follow these steps to set up your ESP8266 module in the Arduino IDE:
   - Go to **File** > **Preferences**, and under the **Additional Boards Manager URLs**, add the following URL:  
     `http://arduino.esp8266.com/stable/package_esp8266com_index.json`
   - Next, go to **Tools** > **Board** > **Boards Manager**, search for `esp8266` and install the latest version.

3. **Install the Required Dependencies**  
   In the Arduino IDE, you will need to install libraries to interface with the sensors and the Wi-Fi. These are included in the repo, but ensure you add them to the Arduino IDE using the **Library Manager**.

4. **Upload the Code to ESP8266**  
   Upload the ESP8266 code from this repository to the module using the Arduino IDE.

### Notes

- Ensure that the ESP8266 module is programmed and running correctly before trying to connect it with the GreenWatch app.
- This app is developed using Flutter, and full details about setting up and running Flutter apps can be found in the [Flutter_Apps README](https://github.com/Batout-asma/Flutter_Apps/blob/main/README.md).

## License

This project is open-source and free to use. Contributions and improvements are welcome!
