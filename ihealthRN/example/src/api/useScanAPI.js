import { useState, useEffect } from "react";
import { DeviceEventEmitter } from "react-native";
import { iHealthDeviceManagerModule } from "@ihealth/ihealthlibrary-react-native";

const useScanAPI = () => {
	const [onScanState, SetOnScanState] = useState({});
	const [isScanning, setScanning] = useState(false);

	const scanDevice = (type) => {
		console.log("scan device: " + type);
		setScanning(true);
		iHealthDeviceManagerModule.startDiscovery(type);
	};

	useEffect(() => {
		const scanListener = DeviceEventEmitter.addListener(
			iHealthDeviceManagerModule.Event_Scan_Device,
			(event) => {
				console.log(event);
				SetOnScanState(event);
			}
		);

		const scanFinishListener = DeviceEventEmitter.addListener(
			iHealthDeviceManagerModule.Event_Scan_Finish,
			() => {
				setScanning(false);
			}
		);

		return () => {
			scanListener.remove();
			scanFinishListener.remove();
		};
	}, []);

	return {
		onScanState,
		isScanning,
		scanDevice,
	};
};

export default useScanAPI;
