import { ScrollView, TextInput, StyleSheet, Text, Pressable } from "react-native";
import useScanAPI from "../api/useScanAPI";
import useConnectAPI from "../api/useConnectAPI";
import io from "socket.io-client";
import Permission from "./Permission";
import { useEffect } from "react";
import { useNavigation } from "@react-navigation/native";
import { Input } from "@rneui/themed";
import { Button } from "@rneui/base";



const socket = io("http://15.237.182.124:3000");

const Data = () => {
	const { onScanState, isScanning, scanDevice } = useScanAPI();
	const {
		onConnectedState,
		onConnectFailState,
		disconnectDevice,
		onDisConnectState,
		isConnecting,
		connectDevice,
	} = useConnectAPI();
	const navigation = useNavigation();
	// Permission();

	const handleScan = (type) => {
		// setScanDevices([]);
		scanDevice(type);
	};

	useEffect(() => {
		if (!isScanning) {
			socket.emit("scanned-devices", [onScanState]);
		}
	}, [isScanning]);

	useEffect(() => {
		if (onConnectedState.mac) {
			socket.emit("connected-device", {
				onConnectedState,
			});
			navigation.navigate("Device", {
				mac: onConnectedState.mac,
				type: onConnectedState.type,
				socket,
			});
		}
	}, [onConnectedState]);

	useEffect(() => {
		if (onDisConnectState.mac)
			socket.emit("disconnected-device", { onDisConnectState });
	}, [onDisConnectState]);

	// useEffect(() => {
	// 	if (onScanState.mac != null && isScanning === false) {
	// 		if (scanDevices.length > 0) {
	// 			socket.emit("scanned-devices", scanDevices);
	// 			setScanDevices([]);
	// 		}
	// 	}
	// }, [onScanState, isScanning, scanDevices]);

	useEffect(() => {
		socket.on("connect", () => {
			console.log("connected");
		});
		socket.on("disconnect", () => {
			console.log("disconnected");
		});

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

		socket.on("disconnect-device-bst", (data) => {
			if (data.mac && data.type) disconnectDevice(data.mac, data.type);
		});
		return () => {
			// socket.disconnect();
		};
	}, []);

	return (
		<ScrollView>
			<Pressable onPress={() => navigation.navigate("callPage")}>
				<Text>Call</Text>
			</Pressable>
			{/* <TextInput style={styles.input} placeholder="Age" />
			dfsjfdshkjfdshajfdsahds
			<Button onPress={() => console.log("press")}>START</Button> */}
		</ScrollView>
	);
};

const styles = StyleSheet.create({
	input: {
		height: 40,
		margin: 12,
		borderWidth: 1,
		padding: 10,
	},
});

export default Data;
