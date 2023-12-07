import React, { useEffect, useState } from "react";
import { View, Text, StyleSheet, ScrollView } from "react-native";
import { ListItem } from "@rneui/themed";
import useScanAPI from "../api/useScanAPI";
import useConnectAPI from "../api/useConnectAPI";
import deviceAPIs from "../api/getAPIs";

import io from "socket.io-client";
const socket = io("http://15.237.182.124:3000");

const DeviceTypes = [
	"AM3S",
	"AM4",
	"AM5",
	"AM6",
	"BG1",
	"BG1S",
	"BG5",
	"BG5S",
	"BG1A",
	"BP3L",
	"BP5",
	"BP5S",
	"BP7",
	"BP7S",
	"KN550",
	"HS2",
	"HS4",
	"HS4S",
	"HS6",
	"PO1",
	"PO3",
	"ECG3",
	"ECG3USB",
	"FDIR_V3",
	"TS28B",
	"NT13B",
	"PT3SBT",
	"HS2S",
];

const SelectScreen = ({ navigation }) => {
	const { onScanState, isScanning, scanDevice } = useScanAPI();
	const [scanDevices, setScanDevices] = useState([]); // [{mac: string, type: string}]
	const {
		onConnectedState,
		onConnectFailState,
		onDisConnectState,
		connectDevice,
	} = useConnectAPI();
	const [connectedDevices, setConnectedDevices] = useState([]); // [{mac: string, type: string}

	const handleScan = (type) => {
		setScanDevices([]);
		scanDevice(type);
	};

	useEffect(() => {
		socket.on("connect", () => {
			console.log("connected");
		});
		socket.on("disconnect", () => {
			console.log("disconnected");
		});
		// socket.on('message', (data) => {
		//   console.log(data);
		// });

		// socket.on('doctor-message-broadcast', (data) => {
		//   console.log(data);
		// });

		// socket.on('init', (data) => {
		//   console.log(data);
		// });

		socket.on("scan-device-bst", (data /* {type: string } */) => {
			handleScan(data.type);
			console.log({ scan: data });
		});

		socket.on(
			"connect-device-bst",
			(data /* {mac: string, type: string} */) => {
				connectDevice(data.mac, data.type);
				console.log({ data });
			}
		);
		return () => {
			// socket.disconnect();
		};
	}, []);

	useEffect(() => {
		if (onScanState.mac != null) {
			setScanDevices([...scanDevices, onScanState]);
		}
	}, [onScanState]);

	useEffect(() => {
		if (onConnectedState.mac != null) {
			setConnectedDevices([...connectedDevices, onConnectedState]);
			socket.emit("connected-device", {
				connectedDevices,
				onConnectedState,
				onConnectFailState,
				onDisConnectState,
			});
		}
		// if (onDisConnectState.mac != null) {
		//   setConnectedDevices(connectedDevices.filter(item => item.mac != onDisConnectState.mac));
		//   // const fn = Reflect.get(deviceAPIs.getDeviceAPI(onDisConnectState.type).apis, 'disconnect', onDisConnectState.mac);
		//   // console.log({fn})
		//   // fn(onDisConnectState.mac);
		// }
		console.log({
			onConnectedState,
			onConnectFailState,
			onDisConnectState,
			connectedDevices,
		});
	}, [onConnectedState, onConnectFailState, onDisConnectState]);

	useEffect(() => {
		if (onScanState.mac != null && isScanning === false) {
			if (scanDevices.length > 0) {
				socket.emit("scanned-devices", scanDevices);
				setScanDevices([]);
			}
		}
	}, [onScanState, isScanning, scanDevices]);

	return (
		<ScrollView>
			{connectedDevices.map((item, index) => {
				return (
					item.type && (
						<ListItem
							key={index}
							onPress={() => {
								// navigation.navigate('Scan', { type: item });
								navigation.navigate("Device", {
									mac: item.mac,
									type: item.type,
									socket,
								});
							}}
							bottomDivider
						>
							<ListItem.Content>
								<ListItem.Title>{item.type}</ListItem.Title>
							</ListItem.Content>
							<ListItem.Chevron />
						</ListItem>
					)
				);
			})}
		</ScrollView>
	);
};

const styles = StyleSheet.create({
	container: {
		flexDirection: "row",
		justifyContent: "flex-start",
		alignItems: "center",
	},
	textContainer: {
		justifyContent: "center",
		alignItems: "center",
		width: 100,
		height: 50,
	},
	picker: {
		flex: 1,
		height: 50,
	},
});

export default SelectScreen;
