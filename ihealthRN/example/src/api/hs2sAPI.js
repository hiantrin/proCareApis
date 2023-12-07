import { HS2SModule } from "@ihealth/ihealthlibrary-react-native";

export default {
	apis: {
		disconnect: (mac) => HS2SModule.disconnect(mac),
		measure: (mac, weight, age, height, gender) =>
			HS2SModule.measure(
				mac,
				0,
				"1234567891234567",
				0,
				weight,
				age,
				height,
				gender,
				1,
				0
			),
		getBattery: (mac) => HS2SModule.getBattery(mac),
		getMemoryData: (mac) => HS2SModule.getMemoryData(mac, "1234567891234567"),
		getInfo: (mac) => HS2SModule.getDeviceInfo(mac),
		getUserInfo: (mac) => HS2SModule.getUserInfo(mac),
	},
};
