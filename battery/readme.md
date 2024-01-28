https://christitus.com/laptop-power-management/

install:
sudo apt install acpi-support acpid acpi linux-cpupower cpufrequtils

Setting Min/Max Power Example
cpupower frequency-set -g powersave -d 0.8G -u 1.2G

Check Frequency
cpufreq-info

Disable Turbo
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo

Turn off CPU Cores
Taking a CPU core offline (Note: you can’t offline cpu0)
echo 0 > /sys/devices/system/cpu/cpu#/online

check power consumption
sudo powertop
