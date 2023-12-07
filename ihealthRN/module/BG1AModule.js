'use strict';

var {NativeModules} = require('react-native');

var RCTModule = NativeModules.BG1AModule

 /**
  * @module BG1AModule
  */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * get BG1A device information
   * @param {string} mac Device's mac address
   */
  getDeviceInfo: function (mac) {
    RCTModule.getDeviceInfo(mac)
  },

  /**
   * Set BG1A measure mode
   * @param {string} mac Device's mac address
   */
  setMeasureMode: function (mac, mode) {
    RCTModule.setMeasureMode(mac, mode)
  },

  /**
   * Set BG1A time
   * @param {string} mac Device's mac address
   */
  setDeviceTime: function (mac) {
    RCTModule.setDeviceTime(mac)
  },

  /**
   * Get BG1A history data
   * @param {string} mac Device's mac address
   */
  getHistoryData: function (mac) {
    RCTModule.getHistoryData(mac)
  },

  /**
   * Delete BG1A history data
   * @param {string} mac Device's mac address
   */
  deleteHistoryData: function (mac) {
    RCTModule.deleteHistoryData(mac)
  },

  /**
   * Disconnect the BG1A
   * @param mac The mac address for BG1S
   */
  disconnect: function (mac) {
    RCTModule.disconnect(mac)
  },

  /**
   * Get all connected BG1A device
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  }
}

