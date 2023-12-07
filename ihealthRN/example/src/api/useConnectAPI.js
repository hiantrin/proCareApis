import { useState, useEffect } from "react";
import { DeviceEventEmitter } from "react-native";
import { iHealthDeviceManagerModule } from "@ihealth/ihealthlibrary-react-native";

const useConnectAPI = () => {
	const [onConnectedState, setConnectedState] = useState({});
	const [onConnectFailState, setConnectFailState] = useState({});
	const [onDisConnectState, setDisConnectState] = useState({});
	const [isConnecting, setConnecting] = useState(false);

	const connectDevice = (mac, type) => {
		console.log("connect device: ", mac, type);
		setConnecting(true);
		iHealthDeviceManagerModule.connectDevice(mac, type);
	};

	const disconnectDevice = (mac, type) => {
		console.log("disconnect device: ", mac, type);
		iHealthDeviceManagerModule.disconnectDevice(mac, type);
	};

	useEffect(() => {
		const connectedListener = DeviceEventEmitter.addListener(
			iHealthDeviceManagerModule.Event_Device_Connected,
			(event) => {
				// console.log(iHealthDeviceManagerModule.Event_Device_Connected, event);
				console.log("event", event);
				setConnecting(false);
				setConnectedState(event);
			}
		);

		const connectFailListener = DeviceEventEmitter.addListener(
			iHealthDeviceManagerModule.Event_Device_Connect_Failed,
			(event) => {
				console.log(
					iHealthDeviceManagerModule.Event_Device_Connect_Failed,
					event
				);
				setConnectFailState(event);
			}
		);

		const disconnectListener = DeviceEventEmitter.addListener(
			iHealthDeviceManagerModule.Event_Device_Disconnect,
			(event) => {
				console.log(iHealthDeviceManagerModule.Event_Device_Disconnect, event);
				setDisConnectState(event);
			}
		);

		return () => {
			connectedListener.remove();
			connectFailListener.remove();
			disconnectListener.remove();
		};
	}, []);

	return {
		connectDevice,
		disconnectDevice,
		onConnectedState,
		onConnectFailState,
		onDisConnectState,
		isConnecting,
	};
};

export default useConnectAPI;
