# Copyright (C) 2020 Timotej Šiškovič
# SPDX-License-Identifier: GPL-3.0-only
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.

CC = gcc -std=gnu99
CFLAGS = -Wextra -Wall `pkg-config --cflags openssl`
BUILD_DIR = build

# dir having our version of mqtt_pal.h must preceede dir of MQTT-C to override this hdr
INCLUDES = -Isrc/include -Ic-rbuf/include -Imqtt/include -IMQTT-C/include

all: test

c-rbuf/build/ringbuffer.o:
	cd c-rbuf && $(MAKE) build/ringbuffer.o

$(BUILD_DIR)/ws_client.o: src/ws_client.c src/include/ws_client.h src/include/common_internal.h
	$(CC) -o $(BUILD_DIR)/ws_client.o -c src/ws_client.c $(CFLAGS) $(INCLUDES)

$(BUILD_DIR)/test.o: src/test.c src/include/ws_client.h libmqttwebsockets.a
	$(CC) -o $(BUILD_DIR)/test.o -c src/test.c $(CFLAGS) $(INCLUDES)

$(BUILD_DIR)/mqtt_wss_log.o: src/mqtt_wss_log.c src/include/mqtt_wss_log.h
	$(CC) -o $(BUILD_DIR)/mqtt_wss_log.o -c src/mqtt_wss_log.c $(CFLAGS) $(INCLUDES)

$(BUILD_DIR)/mqtt_wss_client.o: src/mqtt_wss_client.c src/include/mqtt_wss_client.h src/include/ws_client.h MQTT-C/include/mqtt.h src/include/common_internal.h
	$(CC) -o $(BUILD_DIR)/mqtt_wss_client.o -c src/mqtt_wss_client.c $(CFLAGS) $(INCLUDES)

libmqttwebsockets.a: $(BUILD_DIR)/mqtt_wss_client.o $(BUILD_DIR)/ws_client.o c-rbuf/build/ringbuffer.o $(BUILD_DIR)/mqtt.o $(BUILD_DIR)/mqtt_wss_log.o
	ar rcs libmqttwebsockets.a $(BUILD_DIR)/mqtt_wss_client.o $(BUILD_DIR)/ws_client.o c-rbuf/build/ringbuffer.o $(BUILD_DIR)/mqtt.o $(BUILD_DIR)/mqtt_wss_log.o

test: $(BUILD_DIR)/test.o libmqttwebsockets.a
	$(CC) -o test $(BUILD_DIR)/test.o libmqttwebsockets.a `pkg-config --libs openssl` -lpthread

$(BUILD_DIR)/mqtt.o: MQTT-C/src/mqtt.c MQTT-C/include/mqtt.h src/include/mqtt_pal.h
	$(CC) -o $(BUILD_DIR)/mqtt.o -c MQTT-C/src/mqtt.c $(CFLAGS) $(INCLUDES)

clean:
	rm -f $(BUILD_DIR)/*
	cd c-rbuf && $(MAKE) clean
	rm -f test libmqttwebsockets.a

install:

dist:

distdir:
