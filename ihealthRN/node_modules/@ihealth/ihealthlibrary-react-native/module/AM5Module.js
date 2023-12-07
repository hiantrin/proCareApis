'use strict';


var {
    NativeModules,
    DeviceEventEmitter
} = require('react-native');

var AM5ProfileModule = require('./AM5ProfileModule.js');

var RCTModule = NativeModules.AM5Module

/**
 * @module AM5Module
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Binding apps and devices.
   * AM5 devices must be bound one-to-one. If you want to use other devices, you must unbind them first and then bind them to other devices.
   * @param {string} mac Device's mac address
   */
   bindDevice: function (mac) {
      RCTModule.bindDevice(mac)
  },

  /**
   * UnBind apps and devices.
   * @param {string} mac Device's mac address
   */
   unBindDevice: function (mac) {
      RCTModule.unBindDevice(mac)
  },

  /**
   * Get information of the device
   * @param {string} mac Device's mac address
   */
   getBasicInfo: function (mac) {
      RCTModule.getBasicInfo(mac)
   },

//   /**
//    * Set time of the device
//    * @param year   year
//    * @param month  month
//    * @param day    day
//    * @param hour   hour
//    * @param minute minute
//    * @param second second
//    * @param week   What day is today?  Effective Value 1-7
//    */
//    setTime: function (mac, year, month, day, minute, second, week) {
//     RCTModule.setTime(mac, year, month, day, minute, second, week)
//    },

   /**
    * Set current time of the device
    */
    setTime: function (mac) {
        RCTModule.setTime(mac)
    },

    /**
     * Get the live data of the device
     * @param {string} mac Device's mac address
     * @param year   Year of birth
     * @param month  Month of birth
     * @param day    Day of birth
     * @param weight weight
     * @param height height
     * @param gander gender male: 1, female: 2
    */
    setUserInfo: function (mac, year, month, day, weight, height, gander) {
        RCTModule.setUserInfo(mac, year, month, day, weight, height, gander)
    },

    /**
     * Set unit
     * When you never set them, treat them as defaults
     * @param {string} mac Device's mac address
     * @param type 0: Distance unit                 unit: 0 default ; 1 KM ; 2 MI
     * @param type 1: Wight unit                    unit: 0 default ; 1 KG ; 2 LB ; 3 ST
     * @param type 2: Temperature unit              unit: 0 default ; 1 °C ; 2 °F
     * @param type 3: Distance at each step         unit: distance (cm)      (default 0cm)
     * @param type 4: Language                      unit: 0 default ; 1 zh ; 2 en ; 3 fr ; 4 de ; 5 it ; 6 es ; 7 ja ; 8 po ; 9 cz
     * @param type 5: Time Mode                     unit: 0 default ; 1 24 hour system ; 2 12 hour system
     * @param type 6: Distance at each step of run  unit: distance (cm)      (default 0cm)
     * @param type 7: GPS calibration switch        unit: 0 default ; 1 open ; 2 close
    */
    setUnit: function (mac, type, unit) {
        RCTModule.setUnit(mac, type, unit)
    },

    /**
     * Reboot the device
     * @param {string} mac Device's mac address
     */
     reboot: function (mac) {
        RCTModule.reboot(mac)
    },

    /**
     * Set Hand Wear Mode
     * @param {string} mac Device's mac address
     * @param mode 0  left-hand   1 right-hand
     */
     setHandWearMode: function (mac, mode) {
        RCTModule.setHandWearMode(mac, mode)
    },

    /**
     * Get the live data of the device
     * @param {string} mac Device's mac address
     */
     getLiveData: function (mac) {
        RCTModule.getLiveData(mac)
    },

    /**
     * Sync health data from device
     * @param {string} mac Device's mac address
     */
     syncHealthData: function (mac) {
        RCTModule.syncHealthData(mac)
    },

    /**
     * Stop sync health data from device
     * @param {string} mac Device's mac address
     */
     stopSyncHealthData: function (mac) {
        RCTModule.stopSyncHealthData(mac)
    },

    /**
     * Get all connected AM4 device
     *
     * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
     */
    getAllConnectedDevices: function () {
        RCTModule.getAllConnectedDevices()
    },
    
    disconnect: function (mac) {
       RCTModule.disconnect(mac)
   },
}
