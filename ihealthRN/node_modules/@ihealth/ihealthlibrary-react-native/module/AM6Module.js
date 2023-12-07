'use strict';


var {
    NativeModules,
    DeviceEventEmitter
} = require('react-native');

var AM6ProfileModule = require('./AM6ProfileModule.js');

var RCTModule = NativeModules.AM6Module

/**
 * @module AM6Module
 */
module.exports = {

    Event_Notify: RCTModule.Event_Notify,

    getAllConnectedDevices: function () {
        RCTModule.getAllConnectedDevices()
    },
    
    disconnect: function (mac) {
       RCTModule.disconnect(mac)
    },

    getDeviceInfoAndSyncTime: function (mac, is24Hour) {
        RCTModule.getDeviceInfoAndSyncTime(mac, is24Hour)
    },

    setUserInfo: function (mac, userIds, gender, age, height, weight) {
        RCTModule.setUserInfo(mac, userIds, gender, age, height, weight)
    },

    setPhonePlatform: function (mac) {
        RCTModule.setPhonePlatform(mac)
    },

    notifyMessage: function (mac, date, status, type, title, content) {
        RCTModule.notifyMessage(mac, date, status, type, title, content)
    },
    
    findDevice: function (mac, start) {
        RCTModule.findDevice(mac, start)
    },

    rebootDevice: function (mac) {
        RCTModule.rebootDevice(mac)
    },

    getTime: function (mac) {
        RCTModule.getTime(mac)
    },

    setTargetRemind: function (mac, isEnable, calorie, step) {
        RCTModule.setTargetRemind(mac, isEnable, calorie, step)
    },

    getTargetRemind: function (mac) {
        RCTModule.getTargetRemind(mac)
    },

    setSedentaryRemind: function (mac, enable, start, end) {
        RCTModule.setSedentaryRemind(mac, enable, start, end)
    },

    getSedentaryRemind: function (mac) {
        RCTModule.getSedentaryRemind(mac)
    },

    setRaiseToLightRemind: function (mac, enable, start, end) {
        RCTModule.setRaiseToLightRemind(mac, enable, start, end)
    },

    getRaiseToLightRemind: function (mac) {
        RCTModule.getRaiseToLightRemind(mac)
    },

    setDoNotDisturbMode: function (mac, enable, start, end) {
        RCTModule.setDoNotDisturbMode(mac, enable, start, end)
    },

    getDoNotDisturbMode: function (mac) {
        RCTModule.getDoNotDisturbMode(mac)
    },

    setWearHand: function (mac, type) {
        RCTModule.setWearHand(mac, type)
    },

    getWearHand: function (mac) {
        RCTModule.getWearHand(mac)
    },
    
    setAlarmClockList: function (mac, clockList) {
        RCTModule.setAlarmClockList(mac, clockList)
    },

    getAlarmClockList: function (mac) {
        RCTModule.getAlarmClockList(mac)
    },

    startBind: function (mac) {
        RCTModule.startBind(mac)
    },

    bindUserSuccess: function (mac, userIds) {
        RCTModule.bindUserSuccess(mac, userIds)
    },

    bindUserFail: function (mac) {
        RCTModule.bindUserFail(mac)
    },

    unBindUser: function (mac, userIds) {
        RCTModule.unBindUser(mac, userIds)
    },

    readySyncData: function (mac) {
        RCTModule.readySyncData(mac)
    },

    getDailyData: function (mac) {
        RCTModule.getDailyData(mac)
    },

    getStepData: function (mac) {
        RCTModule.getStepData(mac)
    },
    
    getSleepData: function (mac) {
        RCTModule.getSleepData(mac)
    },

    getStepData: function (mac) {
        RCTModule.getStepData(mac)
    },

    getHeartRateData: function (mac) {
        RCTModule.getHeartRateData(mac)
    },

    getBloodOxygenData: function (mac) {
        RCTModule.getBloodOxygenData(mac)
    },

    getActivityData: function (mac) {
        RCTModule.getActivityData(mac)
    },

    deleteData: function (mac, num) {
        RCTModule.deleteData(mac, num)
    },
}
