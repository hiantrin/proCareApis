import { BG1AModule } from '@ihealth/ihealthlibrary-react-native';

export default {
  apis: {
    getAllConnectedDevices: () => BG1AModule.getAllConnectedDevices(),
    getDeviceInfo: (mac) => BG1AModule.getDeviceInfo(mac),
    setMeasureMode: (mac) => BG1AModule.setMeasureMode(mac, 1),
    setDeviceTime: (mac) => BG1AModule.setDeviceTime(mac),
    getHistoryData: (mac) => BG1AModule.getHistoryData(mac),
    deleteHistoryData: (mac) => BG1AModule.deleteHistoryData(mac),
    disconnect: (mac) => BG1AModule.disconnect(mac)
  },
}
