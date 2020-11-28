# Jetson Nano Setup

## Development Board Pinout
Pin numbering is read with even numbered pins next to the short edge of the Development Board board.

| Function | Name | Pin | Pin | Name | Function |
|-------------------------|------------|-----|-----|------------|-------------------------|
|  | 3.3VDC | 1 | 2 | 5.0VDC | Power |
| I2C Data | SDA1 | 3 | 4 | 5.0VDC | Power |
| I2C Clock | SCL1 | 5 | 6 | GND | Ground |
|  | AUDIO_MCLK | 7 | 8 | TXD0 | Serial Tx |
| Ground | GND | 9 | 10 | RXD0 | Serial Rx |
| Serial Flow Ctrl | UART2_RTS | 11 | 12 | DAP4_SCLK |  |
| SPI Clock | SPI2_SCK | 13 | 14 | GND | Ground |
|  | LCD_TE | 15 | 16 | SPI2_CS1 | SPI Chip Select |
| Power | 3.3VDC | 17 | 18 | SPI2_CS0 | SPI Chip Select |
| SPI Master-Out-Slave-In | SPI_MOSI | 19 | 20 | GND | Ground |
| SPI Master-In-Slave-Out | SPI_MISO | 21 | 22 | SPI2_MISO | SPI Master-In-Slave-Out |
| SPI Clock | SPI_SCK | 23 | 24 | SPI1_CSO | SPI Chip Select |
| Ground | GND | 25 | 26 | SPI1_CS1 | SPI Chip Select |
| I2C Data | ID_SDA | 27 | 28 | ID_SCL | I2C Clock |
|  | CAM_AF_EN | 29 | 30 | GND | Ground |
|  | GPIO_PZ0 | 31 | 32 | LCD_BL_PWM |  |
|  | GPIO_PE6 | 33 | 34 | GND | Ground |
|  | DAP4_FS | 35 | 36 | UART2_CTS | Serial Flow Ctrl |
| SPI Master-Out-Slave-In | SPI2_MOSI | 37 | 38 | DAP4_DIN |  |
| Ground | GND | 39 | 40 | DAP4_DOUT |  |

## Common Configuration
### Power Supply
The Jetson Nano Development Kit can be powered from the Micro-USB Port, the DC Jack, and GPIO Power Pins by a 5V source.

The Micro-USB Port is intended to conveniently provide power for debugging and testing. It accepts power at 5V / 2A
Avoid using the Micro USB to power the Jetson for prolonged periods of time or if powerful peripheries are connected.

The DC Jack accepts power at 5V / 4A. When using the DC Jack to as a primary power source, it is recommended to reinforce the connection with hot glue.

The GPIO Power Pins accepts power at 5V / 3A per pin. Use both pins to source up to 6A to support powerful peripherals. When using the GPIO pins as a primary power source, it is recommended to reinforce the connection with hot glue.

When using a smoothed regulator with large capacitors, wait a few seconds after unplugging the power supply during a plug-unplug operation. Otherwise the Jetson Nano will not power down fully and register a brownout.

### Serial Connection
Connect the host device (e.g. Autopilot)'s serial Transmit wire to the Jetson Nano's Receive pin, i.e. GPIO 10 Serial Rx, then connect the host device's serial Receive wire to the Jetson Nano's Transmit pin, i.e. GPIO 8 Serial Tx.

Always connect a ground wire between host device and companion computer. Using GPIO 9 GND is recommended.

### Networking
To access the Jetson Nano in headless mode over a ssh connection, edit `/etc/network/interfaces` and add
```
auto wlan0
``` 
This allows the Jetson Nano to automatically connect to a WiFi network on bootup.

It is also recommended to edit `/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf`, setting 
```
wifi.powersave = 2
```
This disables wifi power saving, which often helps mitigating WiFi dropouts.

## Multi-Device usage

### Formatting and restoring from image
When deploying an application across multiple Nvidia Jetson Nano computers, for example on board multiple UAVs in a payload transport team, it is recommended to clone and restore SD card images for consistent performance.

First get the device id of the SD card 
```
fdisk -l
```

Then use dd to make a diskimage by running
```
dd bs=4M if=/dev/${device-id} of=${image-name}.img
```
the blocksize can be controlled by `bs`, where 512 is often a good option

To restore the diskimage to another SD card, run
```
dd if=${image-name}.img of=/dev/${device-id}
```

Otherwise, Balena Etcher can be used as well.

It is sometimes possible to shrink a large SD image with unallocated parts in the tail end, to fit into a smaller SD card. To do so, first run
```
fdisk -l ${image-name}.img
```

Note the block-size by reading `Units = sectors of 1 * 512 = 512 bytes` where 512 may be some other number.
Identify the primary data partition, possibly by size, then note the block number where the partition ends under END. Next carry out the shrinking by
```
truncate --size=$[(${END}+1)*${block-size}] ${image-name}.img
```


### Changing username and hostname
After cloning SD card images, the OS in the child SD image retains the username and hostname of the parent. It is therefore often necessary to change them to distinguish between different Jetson computers.

To change username of the primary account, root access is necessary. Otherwise, another temporary account can be created but doing so is unnecessarily complicated. To obtain root access for the first time, issue a password with 
```
sudo passwd root
```
from an existing user account.

Next, log out of the user account and login to an root account through a tty console or ssh. Change the username and the home folder with 
```
usermod -l ${new-username} -d /home/${new-username} -m ${old-username}
```
Finally, change the hostname by editing `/etc/hostname`

## Emergencies
The Jetson Nano base image enables the full range of Magic Sysrq keys. The REISUB sequence (or parts of it) are invaluable in disaster recovery.


