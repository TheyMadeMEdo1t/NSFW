# 💀AnySniff
![WindowsTerminal_EXgGPGWIwz_transparent](https://github.com/user-attachments/assets/cd05cce0-60c9-4f02-a5e1-4d51f5b2b25b)


AnySniff is a tool for monitoring TCP connections of processes like AnyDesk on Windows. It uses the CVE-2024-52940 vulnerability to track open connections and log IPs, ports, and other relevant details.

## ⚙Features

- Monitors TCP connections of targeted processes (e.g., AnyDesk).
- Logs IP addresses, ports, and process details to a log file.
- Allows real-time sniffing of network traffic.
- Provides a simple menu-driven interface.

## 💽Requirements

- Python 3.x
- Windows operating system
- `pyfiglet` library for ASCII art
- `colorama` library for color support

## 🛠️Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/yourusername/AnySniff.git
    ```
2. Navigate to the project directory:
    ```bash
    cd AnySniff
    ```
3. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## 🍴Usage

1. Run the script:
    ```bash
    python anysniff.py
    ```
2. Follow the menu options:
    - **Start Sniff**: Starts sniffing for targeted TCP connections.
    - **Info**: Displays information about the tool and its usage.
    - **Exit**: Exits the program.
3. How to sniff?
    - After starting the sniffer, connect to any remote machine via AnyDesk and look at the terminal.
### **Enjoy!**

## 📄Logs

All connection details will be logged in the current directory. The logs are saved with filenames that include the timestamp, such as `ip_2024-12-02_08-45-00.log`.

## 💊Acknowledgements

- This tool leverages CVE-2024-52940 for monitoring AnyDesk connections.
- Created by MKultra69 with love.

## ❓P.S

- I don't give a shit why or how.
