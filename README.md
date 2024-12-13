# GreenWatch App

**GreenWatch** is a Flutter application that allows users to monitor the conditions of their greenhouse remotely. With the help of the **ESP8266 module**, which is connected to Wi-Fi, the app displays real-time data about:

- **Temperature**
- **Humidity**
- **Soil Humidity**
- **Luminosity**

Additionally, **GreenWatch** includes a **shop** feature where users can browse and purchase agricultural products needed for greenhouse management.

## Getting Started

This project consists of two main components:
1. **GreenWatch Flutter App** - The mobile app to monitor greenhouse conditions and shop for agricultural products.
2. **ESP8266 Code** - Code for the ESP8266 module that connects to Wi-Fi and sends sensor data.

### Prerequisites

To run this project, you will need:

1. **ESP8266 Module** - This project relies on the ESP8266 for sending real-time sensor data to the app.  
2. **Arduino IDE** - You will need the Arduino IDE to program the ESP8266 module and install necessary libraries.  
3. **VS Code** - To develop and run the Flutter app.  
4. **Android Studio (optional)** - For simulating the app on an Android device or for working with Android emulators.

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

### Setting Up the Flutter App

1. **Install Flutter**  
   If you haven’t already, download and install [Flutter](https://flutter.dev/docs/get-started/install) on your machine.

2. **Clone the Repository**  
   Clone this repository to your local machine using Git or by downloading the ZIP.

3. **Install Dependencies**  
   In the project directory, run the following command to install the required Flutter dependencies:
   ```bash
   flutter pub get
   ```

4. **Run the App**  
   You can either connect your Android device via USB or use Android Studio for an emulator. Then, run the app with the following command:
   ```bash
   flutter run
   ```

5. **Connect the ESP8266**  
   Ensure that the ESP8266 is connected to Wi-Fi network as well your android device. The app will start receiving real-time data from the ESP8266.

### Shop Feature

In addition to monitoring greenhouse conditions, **GreenWatch** includes a shop where users can purchase agricultural products like fertilizers, seeds, tools, and other greenhouse management essentials. Browse the available products, add them to your cart, and make purchases directly from the app.

### Notes

- Make sure your ESP8266 is programmed and running properly before trying to connect it with the app.
- You’ll need **VS Code** and **Android Studio** to develop and test the app. You can either use a physical Android device or an emulator to simulate the app.

## Dependencies

- **Flutter**  
- **Dart**  
- **ESP8266 Libraries** for Arduino

## License

This project is open-source and free to use. Contributions and improvements are welcome!
