import { useState, useEffect } from "react";
import { DeviceEventEmitter } from "react-native";
import { iHealthDeviceManagerModule } from "@ihealth/ihealthlibrary-react-native";
import deviceAPIs from "../api/getAPIs";

const useDeviceAPI = (deviceType) => {
	const [response, setResponse] = useState("");

	useEffect(() => {
		const notifyListener = DeviceEventEmitter.addListener(
			deviceAPIs.getDeviceNotify(deviceType),
			(event) => {
				console.log("event ", event);
				setResponse(JSON.stringify(event));
			}
		);

		return () => {
			notifyListener.remove();
		};
	}, []);

	return {
		response,
	};
};

export default useDeviceAPI;
