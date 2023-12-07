import { BP550BTModule } from "@ihealth/ihealthlibrary-react-native";

export default {
	apis: {
		getAllConnectedDevices: () => BP550BTModule.getAllConnectedDevices(),
		getBattery: (mac) => BP550BTModule.getBattery(mac),
		getOffLineNum: (mac) => BP550BTModule.getOffLineNum(mac),
		getOffLineData: (mac) => BP550BTModule.getOffLineData(mac),
		getFunctionInfo: (mac) => BP550BTModule.getFunctionInfo(mac),
		setDisplayConfig: (mac) =>
			BP550BTModule.setDisplayConfig(mac, false, false),
		getDisplayConfig: (mac) => BP550BTModule.getDisplayConfig(mac),
		getTime: (mac) => BP550BTModule.getTime(mac),
		transferFinished: (mac) => BP550BTModule.transferFinished(mac),
		disconnect: (mac) => BP550BTModule.disconnect(mac),
	},
};
