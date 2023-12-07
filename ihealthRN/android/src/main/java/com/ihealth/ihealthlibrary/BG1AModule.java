package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg1aControl;
import com.ihealth.communication.control.Bg1aProfile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@ReactModule(name = "BG1AModule")
public class BG1AModule extends iHealthBaseModule {

    private static final String moduleName = "BG1AModule";
    private static final String TAG = "BG1AModule";
    private static final String EVENT_NOTIFY = "event_notify_bg1a";

    public BG1AModule(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
    }

    @Override
    public String getName() {
        return moduleName;
    }

    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> map = new HashMap<>();
        map.put("Event_Notify", EVENT_NOTIFY);
        return map;
    }

    @ReactMethod
    public void getDeviceInfo(String mac) {
        Bg1aControl bg1aControl = getBg1aControl(mac);
        if (bg1aControl != null) {
            bg1aControl.getDeviceInfo();
        }
    }

    @ReactMethod
    public void setMeasureMode(String mac, int mode) {
        Bg1aControl bg1aControl = getBg1aControl(mac);
        if (bg1aControl != null) {
            if (mode == 0) {
                bg1aControl.setMeasureMode(Bg1aProfile.Bg1aModeType.BloodMode);
            } else if (mode == 1) {
                bg1aControl.setMeasureMode(Bg1aProfile.Bg1aModeType.CTLMode);
            } else {
                senErrMessage(400, "Input parameter error", mac);
            }
        }
    }

    @ReactMethod
    public void setDeviceTime(String mac) {
        Bg1aControl bg1aControl = getBg1aControl(mac);
        if (bg1aControl != null) {
            long ts = System.currentTimeMillis();
            bg1aControl.setDeviceTime(ts);
        }
    }

    @ReactMethod
    public void getHistoryData(String mac) {
        Bg1aControl bg1aControl = getBg1aControl(mac);
        if (bg1aControl != null) {
            bg1aControl.getHistoryData();
        }
    }

    @ReactMethod
    public void deleteHistoryData(String mac) {
        Bg1aControl bg1aControl = getBg1aControl(mac);
        if (bg1aControl != null) {
            bg1aControl.deleteHistoryData();
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bg1aControl bg1aControl = getBg1aControl(mac);
        if (bg1aControl != null) {
            bg1aControl.disconnect();
        }
    }

    private void senErrMessage(int errId) {
        WritableMap params = Arguments.createMap();
        params.putInt("errorid", errId);
        sendEvent(EVENT_NOTIFY, params);
    }

    private void senErrMessage(int errId, String description, String mac) {
        WritableMap params = Arguments.createMap();
        params.putString("action", "action_error");
        params.putString("mac", mac);
        params.putString("type", "BG1A");
        params.putInt("error_num", errId);
        params.putString("error_description", description);
        sendEvent(EVENT_NOTIFY, params);
    }

    private Bg1aControl getBg1aControl(String mac) {
        Bg1aControl bg1aControl = iHealthDevicesManager.getInstance().getBg1aControl(mac);
        if (bg1aControl == null) {
            senErrMessage(400);
        }
        return bg1aControl;
    }

    @Override
    public void handleNotify(String mac, String deviceType, String action, String message) {
        WritableMap params = Arguments.createMap();
        params.putString("action", action);
        params.putString("mac", mac);
        params.putString("type", deviceType);
        if (Bg1aProfile.ACTION_MEASURE_RESULT_HISTORY.equals(action)) {
            try {
                JSONObject obj = new JSONObject();
                JSONArray arr = new JSONArray(message);
                obj.put("history", arr);
                message = obj.toString();
            } catch(JSONException e) {
                e.printStackTrace();
            } 
        }
        if (!TextUtils.isEmpty(message)) {
            Utils.jsonToMap(message, params);
        }
        sendEvent(EVENT_NOTIFY, params);
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getBg1aDevices();
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
