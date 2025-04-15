#!/bin/bash
#sudo sysctl -w net.core.rmem_default=67108864 net.core.wmem_default=67108864 #sudo sysctl -w net.core.wmem_max=67108864 net.core.rmem_max=67108864
#sudo ethtool -G eno1 rx 4096 tx 4096
#sudo sysctl -w vm.dirty_background_ratio=90
#sudo sysctl -w vm.dirty_ratio=90
#sudo mount -o remount,noatime, nodiratime /dev/mapper/ubuntu--vg-ubuntu--lv #sudo blockdev --setra 4096 /dev/mapper/ubuntu--vg-ubuntu--lv
#sudo mount -o remount, relatime /dev/mapper/ubuntu--vg-ubuntu--lv
#sudo sysctl -w vm.dirty_background_bytes=134217728
#sudo sysctl -w vm.dirty_bytes=134217728
sudo sysctl -w net.core.wmem_max=62500000 net.core.rmem_max=62500000
RX_FILE=$(date +./usrp_rx%Y-%m-%d_%H-%M-%S.pcm) LOG_FILE="$RX_FILE.log"
echo "Сoxpaнение в þайл: $RX_FILE"
echo "Лог будет сохранен в файл: $LOG_FILE"
sudo ionice -c 1 -n 0 ./rx_samples_to_file \
                --freq 1452480000 \ #1602480000 \
                --rate 122.88e6 \
                --gain 45 \
                --duration 600 \
                --file $RX_FILE \
                --ant "TX/RX" \
                --subdev "A:0" \
                --args="master_clock_rate=122880000.000000,mgmt_addr=192.168.20.2" \
                --progress \
                --stats \
                --spb 300\
                2>&1 | tee "$LOG_FILE"
echo "Файл сохранен: $RX_FILE"
echo "Paзмep þaйла $RX_FILE:"
du -h "$RX_FILE"

# https://files.ettus.com/manual/page_configuration.html