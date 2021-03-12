// Copyright (C) 2020 Timotej Šiškovič
// SPDX-License-Identifier: GPL-3.0-only
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with this program.
// If not, see <https://www.gnu.org/licenses/>.

#ifndef MQTT_5_PROTO_H
#define MQTT_5_PROTO_H

#define MQTT_CTRL_PKT_RSVD        0x0
#define MQTT_CTRL_PKT_CONNECT     0x1
#define MQTT_CTRL_PKT_CONNACK     0x2
#define MQTT_CTRL_PKT_PUBLISH     0x3
#define MQTT_CTRL_PKT_PUBACK      0x4
#define MQTT_CTRL_PKT_PUBREC      0x5
#define MQTT_CTRL_PKT_PUBREL      0x6
#define MQTT_CTRL_PKT_PUBCOMP     0x7
#define MQTT_CTRL_PKT_SUBSCRIBE   0x8
#define MQTT_CTRL_PKT_SUBACK      0x9
#define MQTT_CTRL_PKT_UNSUBSCRIBE 0xA
#define MQTT_CTRL_PKT_UNSUBACK    0xB
#define MQTT_CTRL_PKT_PINGREQ     0xC
#define MQTT_CTRL_PKT_PINGRESP    0xD
#define MQTT_CTRL_PKT_DISCONNECT  0xE
#define MQTT_CTRL_PKT_AUTH        0xF



#endif
