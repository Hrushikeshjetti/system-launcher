# System Launcher and Info Script

A powerful and colorful shell script that combines system information display with an application launcher. Features persistent storage for custom applications, color-coded interface, and comprehensive application management.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Features

- 🖥️ System information display using neofetch
- 🚀 Built-in launcher for common applications
- ✨ Custom application management with persistent storage
- 🎨 Color-coded user interface
- 🔄 Continuous operation mode
- 🗑️ Application removal functionality
- 💾 Configuration file support

## Prerequisites

- Linux-based operating system
- neofetch (`sudo apt-get install neofetch`)
- Basic applications (firefox, gedit, nautilus, gnome-terminal)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/system-launcher.git
   cd system-launcher
   ```

2. Make the script executable:
   ```bash
   chmod +x system_launcher.sh
   ```

## Usage

1. Run the script:
   ```bash
   ./system_launcher.sh
   ```

2. Use the interactive menu to:
   - View system information
   - Launch built-in applications
   - Manage custom applications
   - Launch custom applications

### Managing Custom Applications

#### Adding Applications
1. Select option 'a' from the menu
2. Enter the application name
3. Enter the application command
4. The new application will appear in the menu

#### Removing Applications
1. Select option 'r' from the menu
2. Choose from the list of custom applications
3. Enter the name of the application to remove

### Configuration

Custom applications are stored in `~/.config/system_launcher/custom_apps.conf` and persist between sessions.

## Color Coding

- 🔵 Blue: Headers and sections
- 🟢 Green: Success messages and options
- 🟡 Yellow: Input prompts and processing
- 🔴 Red: Error messages and warnings

## Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you find this project helpful, please consider:
- Giving it a ⭐ star
- Creating a pull request with improvements
- Sharing it with friends

## Acknowledgments

- neofetch for system information display
- The open-source community for inspiration
- All contributors who help improve this project
