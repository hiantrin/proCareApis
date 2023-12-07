import { RecoilRoot } from "recoil";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import PermissionScreen from "./src/screen/PermissionScreen";
import SelectScreen from "./src/screen/SelectScreen";
import ScanScreen from "./src/screen/ScanScreen";
import DeviceScreen from "./src/screen/DeviceScreen";
import Permission from "./src/screen/Permission";
import { useEffect } from "react";
import useScanAPI from "./src/api/useScanAPI";
import useConnectAPI from "./src/api/useConnectAPI";

import io from "socket.io-client";
import Data from "./src/screen/Data";
const socket = io("http://15.237.182.124:3000");
import CallPAge from "./src/screen/CallPage";

const Stack = createNativeStackNavigator();

export default function App() {
	// const { onScanState, isScanning, scanDevice } = useScanAPI();
	// const {
	// 	onConnectedState,
	// 	onConnectFailState,
	// 	onDisConnectState,
	// 	connectDevice,
	// } = useConnectAPI();
	Permission();

	// const handleScan = (type) => {
	// 	setScanDevices([]);
	// 	scanDevice(type);
	// };

	// useEffect(() => {
	// 	if (!isScanning) {
	// 		socket.emit("scanned-devices", [onScanState]);
	// 	}
	// }, [isScanning]);

	// useEffect(() => {
	// 	if (onScanState.mac != null && isScanning === false) {
	// 		if (scanDevices.length > 0) {
	// 			socket.emit("scanned-devices", scanDevices);
	// 			setScanDevices([]);
	// 		}
	// 	}
	// }, [onScanState, isScanning, scanDevices]);

	// useEffect(() => {
	// 	socket.on("connect", () => {
	// 		console.log("connected");
	// 	});
	// 	socket.on("disconnect", () => {
	// 		console.log("disconnected");
	// 	});

	// 	socket.on("scan-device-bst", (data /* {type: string } */) => {
	// 		handleScan(data.type);
	// 		console.log({ scan: data });
	// 	});

	// 	socket.on(
	// 		"connect-device-bst",
	// 		(data /* {mac: string, type: string} */) => {
	// 			connectDevice(data.mac, data.type);
	// 			console.log({ data });
	// 		}
	// 	);
	// 	return () => {
	// 		// socket.disconnect();
	// 	};
	// }, []);

	

	return (
		<RecoilRoot>
			<NavigationContainer>
				<Stack.Navigator>
					{/* <Stack.Screen name="Permission" component={PermissionScreen}/> */}
					{/* <Stack.Screen name="Select" component={SelectScreen} /> */}
					{/* <Stack.Screen name="Scan" component={ScanScreen} /> */}
					<Stack.Screen name="data" component={Data} />
					<Stack.Screen name="Device" component={DeviceScreen} />
					<Stack.Screen name="callPage" component={CallPAge} />
				</Stack.Navigator>
			</NavigationContainer>
		</RecoilRoot>
	);
}
