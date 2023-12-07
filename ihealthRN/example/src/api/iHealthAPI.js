import { useState, useEffect } from 'react';
import { DeviceEventEmitter } from 'react-native';
import { iHealthDeviceManagerModule } from '@ihealth/ihealthlibrary-react-native'

const TAG = 'iHealthAPI';

const sdkAuthWithLicense = (filename) => {
  const authenListener = DeviceEventEmitter.addListener(iHealthDeviceManagerModule.Event_Authenticate_Result, (event) => {
    console.log(TAG + JSON.stringify(event))
    
  })
  iHealthDeviceManagerModule.sdkAuthWithLicense(filename)
}

export default {
  sdkAuthWithLicense,
}
