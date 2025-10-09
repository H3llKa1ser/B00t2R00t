# Monitor and Managed Modes

## Monitor mode

### Steps:

#### 1) Deactivate the NIC

    sudo ip link set dev wlan2 down

#### 2) Set it to monitor mode

    sudo iw dev wlan2 set type monitor

#### 3) Activate the NIC

    sudo ip link set dev wlan2 up

#### 4) Verify that the NIC is up in monitor mode

    sudo iw dev wlan2 info

## Managed Mode

#### 1) Deactivate the NIC

    sudo ip link set dev wlan2 down

#### 2) Set it to managed mode

    sudo iw dev wlan2 set type managed

#### 3) Activate the NIC

    sudo ip link set dev wlan2 up

#### 4) Verify that the NIC is up in managed mode

    sudo iw dev wlan2 info
