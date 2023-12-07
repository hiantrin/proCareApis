import { BG5SModule } from '@ihealth/ihealthlibrary-react-native';

export default {
  apis: {
    getAllConnectedDevices: () => BG5SModule.getAllConnectedDevices(),
    getStatusInfo:       (mac) => BG5SModule.getStatusInfo(mac),
    setTime:             (mac) => BG5SModule.setTime(mac,1,1),
    setUnit:             (mac) => BG5SModule.setUnit(mac,1),
    deleteUsedStrip:     (mac) => BG5SModule.deleteUsedStrip(mac),
    deleteOfflineData:   (mac) => BG5SModule.deleteOfflineData(mac),
    getOfflineData:      (mac) => BG5SModule.getOfflineData(mac),
    startMeasure:        (mac) => BG5SModule.startMeasure(mac,1),
    setOfflineModel:     (mac) => BG5SModule.setOfflineModel(mac,1),
    disConnect:          (mac) => BG5SModule.disConnect(mac)
  }
}
