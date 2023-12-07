package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ido.ble.protocol.model.QuickSportMode;
import com.ihealth.communication.control.Am5Control;
import com.ihealth.communication.manager.iHealthDevicesManager;
import com.ihealth.communication.model.AM5Alarm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModule(name = "AM5Module")
public class AM5Module extends iHealthBaseModule {
    private static final String modelName = "AM5Module";
    private static final String TAG = AM5Module.modelName;

    private static final String EVENT_NOTIFY = "event_notify_am5";

    public AM5Module(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
    }

    @Override
    public String getName() {
        return modelName;
    }

    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> map = new HashMap<>();
        map.put("Event_Notify", EVENT_NOTIFY);
        return map;
    }

    @Override
    public void handleNotify(String mac, String deviceType, String action, String message) {
        WritableMap params = Arguments.createMap();
        params.putString("action", action);
        params.putString("mac", mac);
        params.putString("type", deviceType);
        if (!TextUtils.isEmpty(message)) {
            Utils.jsonToMap(message, params);
        }
        sendEvent(EVENT_NOTIFY, params);
    }

    private static Am5Control getControl(String mac) {
        return iHealthDevicesManager.getInstance().getAm5Control(mac);
    }

    @ReactMethod
    public void bindDevice(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.bindDevice();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void unBindDevice(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.unBindDevice();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void isBind(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.isBind();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getBasicInfo(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.getBasicInfo();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getMacAddress(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.getMacAddress();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getLiveData(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.getLiveData();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getActivityCount(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.getActivityCount();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setTime(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setTime();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    // @ReactMethod
    // public void setTime(String mac, int year, int month, int day, int hour, int minute, int second, int week) {
    //     Am5Control control = getControl(mac);
    //     if (control != null) {
    //         control.setTime(year, month, day, hour, minute, second, week);
    //     } else {
    //         Log.e(TAG, "Can not find AM5 Control mac:" + mac);
    //     }
    // }

    @ReactMethod
    public void setAlarm(String mac, List<AM5Alarm> alarmList) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setAlarm(alarmList);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setGoal(String mac, String goal) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setGoal(goal);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }
    
    @ReactMethod
    public void setLongSit(String mac, int startHour, int startMinute,
                           int endHour,int endMinute, int interval,
                           boolean isOn, boolean[] repeat){
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setLongSit(startHour, startMinute, endHour,
                    endMinute, interval, isOn, repeat);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setUserInfo(String mac, int birthYear, int birthMonth, int birthDay, int weight, int height, int sex) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setUserInfo(birthYear, birthMonth, birthDay, weight, height, sex);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setUnit(String mac, int type, int unit) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setUnit(type, unit);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void reboot(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.reboot();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setHandWearMode(String mac, int mode) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setHandWearMode(mode);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setHeartRateInterval(String mac, int burn, int aerobic, int limit, int userMaxHR) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setHeartRateInterval(burn, aerobic, limit, userMaxHR);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setHeartRateMeasureMode(String mac, int hasTimeRange, int measureMode, int startHour, int startMin, int endHour, int endMin) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setHeartRateMeasureMode(hasTimeRange, measureMode, startHour, startMin, endHour, endMin);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setNotDisturb(String mac, boolean isOpen, int startHour, int startMin, int endHour, int endMin) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setNotDisturb(isOpen, startHour, startMin, endHour, endMin);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setSportMode(String mac, QuickSportMode quickSportMode) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setSportMode(quickSportMode);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setIncomingCallInfo(String mac, String name, String phoneNumber) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setIncomingCallInfo(name, phoneNumber);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setStopInComingCall(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setStopInComingCall();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setNewMessageDetailInfo(String mac, int type, String name, String number, String content) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.setNewMessageDetailInfo(type, name, number, content);
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncConfigData(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.syncConfigData();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void stopSyncConfigData(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.stopSyncConfigData();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncHealthData(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.syncHealthData();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void stopSyncHealthData(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.stopSyncHealthData();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncActivityData(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.syncActivityData();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void stopSyncActivityData(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.stopSyncActivityData();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Am5Control control = getControl(mac);
        if (control != null) {
            control.disconnect();
        } else {
            Log.e(TAG, "Can not find AM5 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getAm5Devices();
        WritableMap params = Arguments.createMap();
        if (devices.size() > 0) {
            WritableArray array = Arguments.createArray();
            for (String device : devices) {
                array.pushString(device);
            }
            params.putArray("devices", array);
            params.putString("action", ACTION_GET_ALL_CONNECTED_DEVICES);
        }
        sendEvent(EVENT_NOTIFY, params);
    }
}
