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
import com.ihealth.communication.control.Am6Control;
import com.ihealth.communication.control.Am6Profile;
import com.ihealth.sdk.command.Am6Command.AlarmClockInfo;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@ReactModule(name = "AM6Module")
public class AM6Module extends iHealthBaseModule {
    
    private static final String modelName = "AM6Module";
    private static final String TAG = AM6Module.modelName;
    private static final String EVENT_NOTIFY = "event_notify_am6";

    public AM6Module(ReactApplicationContext reactContext) {
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

        if (Am6Profile.Action_GetDailyData.equals(action)) {
            
            try {
                JSONArray arr = new JSONArray(message);
                JSONObject obj = new JSONObject();
                obj.put("am6_getDailyData", arr);
                message = obj.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }
            

            // WritableArray writableArray = Arguments.createArray();
            // try {
            //     JSONArray arr = new JSONArray(message);
            //     for (int i = 0; i < arr.length(); i++) {
            //         JSONObject obj = arr.getJSONObject(i);
                    
            //         WritableMap itemParams = Arguments.createMap();      
            //         String date = obj.getString(Am6Profile.GetDailyData_Date);
            //         itemParams.putString(Am6Profile.GetDailyData_Date, date);

            //         int step = obj.getInt(Am6Profile.GetDailyData_Step);
            //         itemParams.putInt(Am6Profile.GetDailyData_Step, step);
                    
            //         int calorie = obj.getInt(Am6Profile.GetDailyData_Calorie);
            //         itemParams.putInt(Am6Profile.GetDailyData_Calorie, calorie);
                    
            //         int bloodOxygen = obj.getInt(Am6Profile.GetDailyData_BloodOxygen);
            //         itemParams.putInt(Am6Profile.GetDailyData_BloodOxygen, bloodOxygen);
                    
            //         int heartRate = obj.getInt(Am6Profile.GetDailyData_HeartRate);
            //         itemParams.putInt(Am6Profile.GetDailyData_HeartRate, heartRate);
                    
            //         int minHeartRate = obj.getInt(Am6Profile.GetDailyData_MinHeartRate);
            //         itemParams.putInt(Am6Profile.GetDailyData_MinHeartRate, minHeartRate);
                    
            //         int maxHeartRate = obj.getInt(Am6Profile.GetDailyData_MaxHeartRate);
            //         itemParams.putInt(Am6Profile.GetDailyData_MaxHeartRate, maxHeartRate);
                    
            //         int meanHeartRate = obj.getInt(Am6Profile.GetDailyData_MeanHeartRate);
            //         itemParams.putInt(Am6Profile.GetDailyData_MeanHeartRate, meanHeartRate);
                    
            //         int restHeartRate = obj.getInt(Am6Profile.GetDailyData_RestHeartRate);
            //         itemParams.putInt(Am6Profile.GetDailyData_MeanHeartRate, restHeartRate);
                    
            //         String minHeartRateTime = obj.getString(Am6Profile.GetDailyData_MinHeartRateTime);
            //         itemParams.putString(Am6Profile.GetDailyData_MinHeartRateTime, minHeartRateTime);
                    
            //         String maxHeartRateTime = obj.getString(Am6Profile.GetDailyData_MaxHeartRateTime);
            //         itemParams.putString(Am6Profile.GetDailyData_MaxHeartRateTime, maxHeartRateTime);
                    
            //         writableArray.pushMap(itemParams);
            //     }
            //     params.putArray("am6_getDailyData", writableArray);
            // } catch (JSONException e) {
            //     e.printStackTrace();
            // }
        } else if (Am6Profile.Action_GetStepData.equals(action)) {

            try {
                JSONArray arr = new JSONArray(message);
                JSONObject obj = new JSONObject();
                obj.put("am6_getStepData", arr);
                message = obj.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }

            // WritableArray writableArray = Arguments.createArray();
            // try {
            //     JSONArray arr = new JSONArray(message);
            //     for (int i = 0; i < arr.length(); i++) {
            //         JSONObject obj = arr.getJSONObject(i);
            //         WritableMap map = Arguments.createMap();
                    
            //         String date = obj.getString(Am6Profile.GetStepData_Date);
            //         map.putString(Am6Profile.GetStepData_Date, date);

            //         JSONArray array = obj.getJSONArray(Am6Profile.GetStepData_List);
            //         WritableArray itemArray = Arguments.createArray();

            //         for (int j = 0; j < array.length(); j++) {
            //             JSONObject o = array.getJSONObject(j);
            //             WritableMap itemParams = Arguments.createMap();
            //             int step = o.getInt(Am6Profile.GetStepData_Step);
            //             itemParams.putInt(Am6Profile.GetStepData_Step, step);

            //             int calorie = o.getInt(Am6Profile.GetStepData_Calorie);
            //             itemParams.putInt(Am6Profile.GetStepData_Calorie, calorie);

            //             int distance = o.getInt(Am6Profile.GetStepData_Distance);
            //             itemParams.putInt(Am6Profile.GetStepData_Distance, distance);

            //             itemArray.pushMap(itemParams);
            //         }
            //         map.putArray("am6_getStepData_item", itemArray);

            //         writableArray.pushMap(map);
            //     }
            //     params.putArray("am6_getStepData", writableArray);
            // } catch (JSONException e) {
            //     e.printStackTrace();
            // }
        } else if (Am6Profile.Action_GetSleepData.equals(action)) {  

            try {
                JSONArray arr = new JSONArray(message);
                JSONObject obj = new JSONObject();
                obj.put("am6_getSleepData", arr);
                message = obj.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }

            // WritableArray writableArray = Arguments.createArray();
            // try {
            //     JSONArray arr = new JSONArray(message);
            //     for (int i = 0; i < arr.length(); i++) {
            //         JSONObject obj = arr.getJSONObject(i);
            //         WritableMap map = Arguments.createMap();
                    
            //         String date = obj.getString(Am6Profile.GetSleepData_Date);
            //         map.putString(Am6Profile.GetSleepData_Date, date);

            //         JSONArray array = obj.getJSONArray(Am6Profile.GetSleepData_List);
            //         WritableArray itemArray = Arguments.createArray();

            //         for (int j = 0; j < array.length(); j++) {
            //             JSONObject o = array.getJSONObject(j);
            //             WritableMap itemParams = Arguments.createMap();

            //             int sleepMode = o.getInt(Am6Profile.GetSleepData_Mode);
            //             itemParams.putInt(Am6Profile.GetSleepData_Mode, sleepMode);

            //             String sleepModeDate = o.getString(Am6Profile.GetSleepData_Mode_Date);
            //             itemParams.putString(Am6Profile.GetSleepData_Mode_Date, sleepModeDate);

            //             itemArray.pushMap(itemParams);
            //         }
            //         map.putArray("am6_getSleepData_item", itemArray);

            //         writableArray.pushMap(map);
            //     }
            //     params.putArray("am6_getSleepData", writableArray);
            // } catch (JSONException e) {
            //     e.printStackTrace();
            // }

        } else if (Am6Profile.Action_GetHeartRateData.equals(action)) {

            try {
                JSONArray arr = new JSONArray(message);
                JSONObject obj = new JSONObject();
                obj.put("am6_getHeartRateData", arr);
                message = obj.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }

            // WritableArray writableArray = Arguments.createArray();
            // try {
            //     JSONArray arr = new JSONArray(message);
            //     for (int i = 0; i < arr.length(); i++) {
            //         JSONObject obj = arr.getJSONObject(i);
            //         WritableMap map = Arguments.createMap();
                    
            //         String date = obj.getString(Am6Profile.GetHeartRateData_Date);
            //         map.putString(Am6Profile.GetHeartRateData_Date, date);

            //         JSONArray array = obj.getJSONArray(Am6Profile.GetHeartRateData_List);
            //         WritableArray itemArray = Arguments.createArray();

            //         for (int j = 0; j < array.length(); j++) {
            //             JSONObject o = array.getJSONObject(j);
            //             WritableMap itemParams = Arguments.createMap();

            //             int heartRate = o.getInt(Am6Profile.GetHeartRateData_HeartRate);
            //             itemParams.putInt(Am6Profile.GetHeartRateData_HeartRate, heartRate);

            //             itemArray.pushMap(itemParams);
            //         }
            //         map.putArray("am6_getHeartRateData_item", itemArray);

            //         writableArray.pushMap(map);
            //     }
            //     params.putArray("am6_getHeartRateData", writableArray);
            // } catch (JSONException e) {
            //     e.printStackTrace();
            // }
        } else if (Am6Profile.Action_GetBloodOxygenData.equals(action)) {

            try {
                JSONArray arr = new JSONArray(message);
                JSONObject obj = new JSONObject();
                obj.put("am6_getBloodOxygenData", arr);
                message = obj.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }

            // WritableArray writableArray = Arguments.createArray();
            // try {
            //     JSONArray arr = new JSONArray(message);
            //     for (int i = 0; i < arr.length(); i++)  {
            //         JSONObject obj = arr.getJSONObject(i);
            //         WritableMap map = Arguments.createMap();

            //         String date = obj.getString(Am6Profile.GetBloodOxygenData_Date);
            //         map.putString(Am6Profile.GetBloodOxygenData_Date, date);
            //         int bloodOxygen = obj.getInt(Am6Profile.GetBloodOxygenData_BloodOxygen);
            //         map.putInt(Am6Profile.GetBloodOxygenData_BloodOxygen, bloodOxygen);

            //         writableArray.pushMap(map);
            //     }
            //     params.putArray("am6_getBloodOxygenData", writableArray);
            // } catch (JSONException e) {
            //     e.printStackTrace();
            // }
            
        } else if (Am6Profile.Action_GetActivityData.equals(action)) {
            
            try {
                JSONArray arr = new JSONArray(message);
                JSONObject obj = new JSONObject();
                obj.put("am6_getActivityData", arr);
                message = obj.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }

            // WritableArray writableArray = Arguments.createArray();
            
            // try {
            //     JSONArray totalArray = new JSONArray(message);

            //     for (int i = 0; i < totalArray.length(); i++) {
            //         JSONObject totalObj = totalArray.getJSONObject(i);
            //         WritableMap mapTotal = Arguments.createMap(); 

            //         String date = totalObj.getString(Am6Profile.GetActivityData_Date);
            //         mapTotal.putString(Am6Profile.GetActivityData_Date, date);

            //         JSONArray pointArr = totalObj.getJSONArray(Am6Profile.GetActivityData_Point);
            //         WritableArray pointArray = Arguments.createArray();

            //         for (int j = 0; j < pointArr.length(); j++) {
            //             JSONObject obj = pointArr.getJSONObject(j);
            //             WritableMap map = Arguments.createMap();        
            //             int calorie = obj.getInt(Am6Profile.GetActivityDataPoint_Calorie);
            //             map.putInt(Am6Profile.GetActivityDataPoint_Calorie, calorie);
                        
            //             int step = obj.getInt(Am6Profile.GetActivityDataPoint_Step);
            //             map.putInt(Am6Profile.GetActivityDataPoint_Step, step);
                        
            //             int heartRate = obj.getInt(Am6Profile.GetActivityDataPoint_HeartRate);
            //             map.putInt(Am6Profile.GetActivityDataPoint_HeartRate, heartRate);                  
                        
            //             int distance = obj.getInt(Am6Profile.GetActivityDataPoint_Distance);
            //             map.putInt(Am6Profile.GetActivityDataPoint_Distance, distance);

            //             pointArray.pushMap(map);
            //         }
            //         mapTotal.putArray("am6_getActivityData_point", pointArray);
                    
            //         JSONArray reportArr = totalObj.getJSONArray(Am6Profile.GetActivityData_Report);
            //         WritableArray reportArray = Arguments.createArray();

            //         for (int j = 0; j < reportArr.length(); j++) {
            //             JSONObject obj = reportArr.getJSONObject(j);
            //             WritableMap map = Arguments.createMap();

            //             String startTime = obj.getString(Am6Profile.GetActivityData_StartDate);
            //             map.putString(Am6Profile.GetActivityData_StartDate, startTime);
                        
            //             String endTime = obj.getString(Am6Profile.GetActivityData_EndDate);
            //             map.putString(Am6Profile.GetActivityData_EndDate, endTime);

            //             int totalTime = obj.getInt(Am6Profile.GetActivityData_TotalTime);
            //             map.putInt(Am6Profile.GetActivityData_TotalTime, totalTime);

            //             int totalDistance = obj.getInt(Am6Profile.GetActivityData_TotalDistance);
            //             map.putInt(Am6Profile.GetActivityData_TotalDistance, totalDistance);

            //             int totalCalorie = obj.getInt(Am6Profile.GetActivityData_TotalCalorie);
            //             map.putInt(Am6Profile.GetActivityData_TotalCalorie, totalCalorie);

            //             int totalStep = obj.getInt(Am6Profile.GetActivityData_TotalStep);
            //             map.putInt(Am6Profile.GetActivityData_TotalStep, totalStep);

            //             int maxPace = obj.getInt(Am6Profile.GetActivityData_MaxPace);
            //             map.putInt(Am6Profile.GetActivityData_MaxPace, maxPace);

            //             int minPace = obj.getInt(Am6Profile.GetActivityData_MinPace);
            //             map.putInt(Am6Profile.GetActivityData_MinPace, minPace);

            //             int maxStepFrequency = obj.getInt(Am6Profile.GetActivityData_MaxStepFrequency);
            //             map.putInt(Am6Profile.GetActivityData_MaxStepFrequency, maxStepFrequency);

            //             int aveHeartRate = obj.getInt(Am6Profile.GetActivityData_AveHeartRate);
            //             map.putInt(Am6Profile.GetActivityData_AveHeartRate, aveHeartRate);

            //             int maxHeartRate = obj.getInt(Am6Profile.GetActivityData_MaxHeartRate);
            //             map.putInt(Am6Profile.GetActivityData_MaxHeartRate, maxHeartRate);

            //             int minHeartRate = obj.getInt(Am6Profile.GetActivityData_MinHeartRate);
            //             map.putInt(Am6Profile.GetActivityData_MinHeartRate, minHeartRate);

            //             int training = obj.getInt(Am6Profile.GetActivityData_TrainingEffect);
            //             map.putInt(Am6Profile.GetActivityData_TrainingEffect, training);

            //             int maxOxygenUpdake = obj.getInt(Am6Profile.GetActivityData_MaxOxygenUptake);
            //             map.putInt(Am6Profile.GetActivityData_MaxOxygenUptake, maxOxygenUpdake);

            //             int bodyCost = obj.getInt(Am6Profile.GetActivityData_BodyEnergyCost);
            //             map.putInt(Am6Profile.GetActivityData_BodyEnergyCost, bodyCost);

            //             int recoveryTime = obj.getInt(Am6Profile.GetActivityData_EstimatedRecoveryTime);
            //             map.putInt(Am6Profile.GetActivityData_EstimatedRecoveryTime, recoveryTime);

            //             int peakTime = obj.getInt(Am6Profile.GetActivityData_PeakTime);
            //             map.putInt(Am6Profile.GetActivityData_PeakTime, peakTime);

            //             int anaerobicTime = obj.getInt(Am6Profile.GetActivityData_AnaerobicTime);
            //             map.putInt(Am6Profile.GetActivityData_AnaerobicTime, anaerobicTime);

            //             int cardioTime = obj.getInt(Am6Profile.GetActivityData_CardioTime);
            //             map.putInt(Am6Profile.GetActivityData_CardioTime, cardioTime);

            //             int fatReductionTime = obj.getInt(Am6Profile.GetActivityData_FatReductionTime);
            //             map.putInt(Am6Profile.GetActivityData_FatReductionTime, fatReductionTime);

            //             int warmUpTime = obj.getInt(Am6Profile.GetActivityData_WarmUpTime);
            //             map.putInt(Am6Profile.GetActivityData_WarmUpTime, warmUpTime);

            //             reportArray.pushMap(map);
            //         }
            //         mapTotal.putArray("am6_getActivityData_report", reportArray);
            //         writableArray.pushMap(mapTotal);
            //     }
               
            //     params.putArray("am6_getActivityData", writableArray);
            // } catch (JSONException e) {
            //     e.printStackTrace();
            // }
        }

         if (!TextUtils.isEmpty(message)) {
            Utils.jsonToMap(message, params);
        }
        sendEvent(EVENT_NOTIFY, params);
    }

    private static Am6Control getControl(String mac) {
        return iHealthDevicesManager.getInstance().getAm6Control(mac);
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getAm6Devices();
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

    @ReactMethod
    public void getDeviceInfoAndSyncTime(String mac, boolean is24Hour) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getDeviceInfoAndSyncTime(is24Hour);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setUserInfo(String mac, String userIds, int gender, int age, int height, float weight) {
        Am6Control control = getControl(mac);
        if (control != null) {
            byte[] byteUserId = new byte[16];
            try {
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] inputBytes = userIds.getBytes();
                byteUserId = md.digest(inputBytes);
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            control.setUserInfo(byteUserId, gender, age, height, weight);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setPhonePlatform(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.setPhonePlatform();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void notifyMessage(String mac, int date, int status, int type, String title, String content) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.notifyMessage(date, status, type, title.getBytes(), content.getBytes());
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void findDevice(String mac, int start) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.findDevice(start);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void rebootDevice(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.rebootDevice();
            
            WritableMap params = Arguments.createMap();
            params.putString("action", "am6_action_rebootDevice");
            params.putString("mac", mac);
            params.putString("type", "AM6");
            sendEvent(EVENT_NOTIFY, params);

        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getTime(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getTime();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setTargetRemind(String mac, boolean isEnable, int calorie, int step) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.setTargetRemind(isEnable, calorie, step);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getTargetRemind(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getTargetRemind();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setSedentaryRemind(String mac, int enable, int start, int end) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.setSedentaryRemind(enable, start, end);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getSedentaryRemind(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getSedentaryRemind();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setRaiseToLightRemind(String mac, int enable, int start, int end) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.setRaiseToLightRemind(enable, start, end);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getRaiseToLightRemind(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getRaiseToLightRemind();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setDoNotDisturbMode(String mac, int enable, int start, int end) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.setDoNotDisturbMode(enable, start, end);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getDoNotDisturbMode(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getDoNotDisturbMode();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setWearHand(String mac, int type) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.setWearHand(type);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getWearHand(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getWearHand();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setAlarmClockList(String mac, String clockList) {
        Am6Control control = getControl(mac);
        if (control != null) {
            ArrayList<AlarmClockInfo> infoList = new ArrayList();
            String[] clockLists = clockList.split(";");
            for (String clock: clockLists) {
                // "1:1-1-1-1-1-1-1:1200"
                AlarmClockInfo info = new AlarmClockInfo();
                String[] cks = clock.split(":");
                
                String open = cks[0];
                info.isOpen = open.equals("1")? true : false;
                
                String[] week = cks[1].split("-");
                boolean[] newWeek = new boolean[7];
                for (int i = 0; i < 7; i++) {
                    newWeek[i] = week[i].equals("1")? true : false;
                }
                info.week = newWeek;

                String ts = cks[2];
                info.ts = Integer.parseInt(ts);
                
                infoList.add(info);
            }
            AlarmClockInfo[] array = infoList.toArray(new AlarmClockInfo[infoList.size()]);
            control.setAlarmClockList(array);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getAlarmClockList(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getAlarmClockList();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void startBind(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.startBind();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void bindUserSuccess(String mac, String userIds) {
        Am6Control control = getControl(mac);
        if (control != null) {
            byte[] byteUserId = new byte[16];
            try {
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] inputBytes = userIds.getBytes();
                byteUserId = md.digest(inputBytes);
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            control.bindUserSuccess(byteUserId);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void bindUserFail(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.bindUserFail();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void unBindUser(String mac, String userIds) {
        Am6Control control = getControl(mac);
        if (control != null) {
            byte[] byteUserId = new byte[16];
            try {
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] inputBytes = userIds.getBytes();
                byteUserId = md.digest(inputBytes);
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            control.unBindUser(byteUserId);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void readySyncData(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.readySyncData();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getDailyData(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getDailyData();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getStepData(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getStepData();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getSleepData(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getSleepData();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getHeartRateData(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getHeartRateData();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getBloodOxygenData(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getBloodOxygenData();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getActivityData(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.getActivityData();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void deleteData(String mac, int num) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.deleteData(num);
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Am6Control control = getControl(mac);
        if (control != null) {
            control.disconnect();
        } else {
            Log.e(TAG, "Can not find AM6 Control mac:" + mac);
        }
    }
}