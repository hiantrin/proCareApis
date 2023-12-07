import { PO3Module } from "@ihealth/ihealthlibrary-react-native";

export default {
  apis: {
    getBattery: (mac) => PO3Module.getBattery(mac),
    startMeasure: (mac) => PO3Module.startMeasure(mac),
    getHistoryData: (mac) => PO3Module.getHistoryData(mac),
    disconnect: (mac) => PO3Module.disconnect(mac),
    getAllConnectedDevices: () => PO3Module.getAllConnectedDevices(),
  },
};
