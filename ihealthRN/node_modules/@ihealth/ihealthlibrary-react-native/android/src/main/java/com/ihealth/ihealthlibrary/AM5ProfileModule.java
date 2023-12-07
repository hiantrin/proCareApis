package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.AmProfile;
import com.ihealth.communication.control.OtherDeviceProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "AM5ProfileModule")
public class AM5ProfileModule extends ReactContextBaseJavaModule {

    private static final String modelName = "AM5ProfileModule";
    private static final String TAG = "AM5ProfileModule";

    private static final String ACTION_ERROR = "ACTION_ERROR";
    private static final String ERROR_NUM = "ERROR_NUM";
    private static final String ERROR_DESCRIPTION = "ERROR_DESCRIPTION";

    private static final String ACTION_USER_BIND = "ACTION_USER_BIND";
    private static final String ACTION_USER_UNBIND = "ACTION_USER_UNBIND";
    private static final String ACTION_FUNCTION_SUPPORT = "ACTION_FUNCTION_SUPPORT";
    private static final String ACTION_BASIC_INFO = "ACTION_BASIC_INFO";
    private static final String ACTION_MAC_ADDRESS = "ACTION_MAC_ADDRESS";

    private static final String MAC_ADDRESS = "MAC_ADDRESS";
    private static final String BASIC_BATTSTATUS = "BASIC_BATTSTATUS";
    private static final String BASIC_DEIVCEID = "BASIC_DEIVCEID";
    private static final String BASIC_ENERGE = "BASIC_ENERGE";
    private static final String BASIC_FIRMWAREVERSION = "BASIC_FIRMWAREVERSION";
    private static final String BASIC_MODE = "BASIC_MODE";
    private static final String BASIC_PAIRFLAG = "BASIC_PAIRFLAG";
    private static final String BASIC_REBOOT = "BASIC_REBOOT";

    private static final String ACTION_LIVE_DATA = "ACTION_LIVE_DATA";
    private static final String ACTION_ACTIVITY_COUNT = "ACTION_ACTIVITY_COUNT";
    private static final String ACTION_SET_TIME = "ACTION_SET_TIME";
    private static final String ACTION_SET_ALARM = "ACTION_SET_ALARM";
    private static final String ACTION_SET_GOAL = "ACTION_SET_GOAL";
    private static final String ACTION_SET_LONG_SIT = "ACTION_SET_LONG_SIT";
    private static final String ACTION_SET_USER_INFO = "ACTION_SET_USER_INFO";
    private static final String ACTION_SET_UNIT = "ACTION_SET_UNIT";
    private static final String ACTION_SET_HAND_WEAR_MODE = "ACTION_SET_HAND_WEAR_MODE";
    private static final String ACTION_SET_UP_HAND_GESTURE = "ACTION_SET_UP_HAND_GESTURE";
    private static final String ACTION_SET_HEART_RATE_INTERVAL = "ACTION_SET_HEART_RATE_INTERVAL";
    private static final String ACTION_SET_HEART_RATE_MEASURE_MODE = "ACTION_SET_HEART_RATE_MEASURE_MODE";
    private static final String ACTION_SET_ONE_KEY_RESET = "ACTION_SET_ONE_KEY_RESET";
    private static final String ACTION_SET_NOT_DISTURB = "ACTION_SET_NOT_DISTURB";
    private static final String ACTION_SET_SPORT_MODE = "ACTION_SET_SPORT_MODE";

    private static final String OPERATION_RESULT = "OPERATION_RESULT";
    private static final String OPERATION_ACTION = "OPERATION_ACTION";

    private static final String ACTION_NOTICE_COMMING_CALL = "ACTION_NOTICE_COMMING_CALL";
    private static final String ACTION_NOTICE_COMMING_CALL_STOP = "ACTION_NOTICE_COMMING_CALL_STOP";
    private static final String ACTION_NOTICE_NEW_MESSAGE = "ACTION_NOTICE_NEW_MESSAGE";

    private static final String ACTION_SYNC_ACTIVITY = "ACTION_SYNC_ACTIVITY";
    private static final String ACTION_SYNC_ACTIVITY_DATA = "ACTION_SYNC_ACTIVITY_DATA";
    private static final String ACTION_SYNC_CONFIG = "ACTION_SYNC_CONFIG";
    private static final String ACTION_SYNC_HEALTH_DATA = "ACTION_SYNC_HEALTH_DATA";
    private static final String ACTION_SYNC_HEALTH_DATA_SPORT = "ACTION_SYNC_HEALTH_DATA_SPORT";
    private static final String ACTION_SYNC_HEALTH_DATA_SLEEP = "ACTION_SYNC_HEALTH_DATA_SLEEP";
    private static final String ACTION_SYNC_HEALTH_DATA_HEART_RATE = "ACTION_SYNC_HEALTH_DATA_HEART_RATE";
    private static final String ACTION_SYNC_HEALTH_DATA_BLOOD_PRESSURE = "ACTION_SYNC_HEALTH_DATA_BLOOD_PRESSURE";

    private static final String OPERATION_STATUS = "OPERATION_STATUS";
    private static final String PROGRESS = "PROGRESS";
    private static final int STATUS_START = 0;
    private static final int STATUS_STOP = 1;
    private static final int STATUS_DOING = 2;
    private static final int STATUS_SUCCESS = 3;
    private static final int STATUS_FAIL = 4;
    private static final int STATUS_CANCEL = 5;

    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";


    public AM5ProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return modelName;
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> constants = new HashMap<>();
        constants.put(ACTION_ERROR, OtherDeviceProfile.ACTION_ERROR);
        constants.put(ERROR_NUM, OtherDeviceProfile.ERROR_NUM);
        constants.put(ERROR_DESCRIPTION, OtherDeviceProfile.ERROR_DESCRIPTION);

        constants.put(ACTION_USER_BIND, OtherDeviceProfile.ACTION_USER_BIND);
        constants.put(ACTION_USER_UNBIND, OtherDeviceProfile.ACTION_USER_UNBIND);
        constants.put(ACTION_FUNCTION_SUPPORT, OtherDeviceProfile.ACTION_FUNCTION_SUPPORT);
        constants.put(ACTION_BASIC_INFO, OtherDeviceProfile.ACTION_BASIC_INFO);
        constants.put(ACTION_MAC_ADDRESS, OtherDeviceProfile.ACTION_MAC_ADDRESS);

        constants.put(MAC_ADDRESS, OtherDeviceProfile.MAC_ADDRESS);
        constants.put(BASIC_BATTSTATUS, OtherDeviceProfile.BASIC_BATTSTATUS);
        constants.put(BASIC_DEIVCEID, OtherDeviceProfile.BASIC_DEIVCEID);
        constants.put(BASIC_ENERGE, OtherDeviceProfile.BASIC_ENERGE);
        constants.put(BASIC_FIRMWAREVERSION, OtherDeviceProfile.BASIC_FIRMWAREVERSION);
        constants.put(BASIC_MODE, OtherDeviceProfile.BASIC_MODE);
        constants.put(BASIC_PAIRFLAG, OtherDeviceProfile.BASIC_PAIRFLAG);
        constants.put(BASIC_REBOOT, OtherDeviceProfile.BASIC_REBOOT);

        constants.put(ACTION_LIVE_DATA, OtherDeviceProfile.ACTION_LIVE_DATA);
        constants.put(ACTION_ACTIVITY_COUNT, OtherDeviceProfile.ACTION_ACTIVITY_COUNT);
        constants.put(ACTION_SET_TIME, OtherDeviceProfile.ACTION_SET_TIME);

        constants.put(ACTION_SET_ALARM, OtherDeviceProfile.ACTION_SET_ALARM);
        constants.put(ACTION_SET_GOAL, OtherDeviceProfile.ACTION_SET_GOAL);
        constants.put(ACTION_SET_LONG_SIT, OtherDeviceProfile.ACTION_SET_LONG_SIT);
        constants.put(ACTION_SET_USER_INFO, OtherDeviceProfile.ACTION_SET_USER_INFO);
        constants.put(ACTION_SET_UNIT, OtherDeviceProfile.ACTION_SET_UNIT);
        constants.put(ACTION_SET_HAND_WEAR_MODE, OtherDeviceProfile.ACTION_SET_HAND_WEAR_MODE);
        constants.put(ACTION_SET_UP_HAND_GESTURE, OtherDeviceProfile.ACTION_SET_UP_HAND_GESTURE);
        constants.put(ACTION_SET_HEART_RATE_INTERVAL, OtherDeviceProfile.ACTION_SET_HEART_RATE_INTERVAL);
        constants.put(ACTION_SET_HEART_RATE_MEASURE_MODE, OtherDeviceProfile.ACTION_SET_HEART_RATE_MEASURE_MODE);
        constants.put(ACTION_SET_ONE_KEY_RESET, OtherDeviceProfile.ACTION_SET_ONE_KEY_RESET);
        constants.put(ACTION_SET_NOT_DISTURB, OtherDeviceProfile.ACTION_SET_NOT_DISTURB);
        constants.put(ACTION_SET_SPORT_MODE, OtherDeviceProfile.ACTION_SET_SPORT_MODE);

        constants.put(OPERATION_RESULT, OtherDeviceProfile.OPERATION_RESULT);
        constants.put(OPERATION_ACTION, OtherDeviceProfile.OPERATION_ACTION);

        constants.put(ACTION_NOTICE_COMMING_CALL, OtherDeviceProfile.ACTION_NOTICE_COMMING_CALL);
        constants.put(ACTION_NOTICE_COMMING_CALL_STOP, OtherDeviceProfile.ACTION_NOTICE_COMMING_CALL_STOP);
        constants.put(ACTION_NOTICE_NEW_MESSAGE, OtherDeviceProfile.ACTION_NOTICE_NEW_MESSAGE);

        constants.put(ACTION_SYNC_ACTIVITY, OtherDeviceProfile.ACTION_SYNC_ACTIVITY);
        constants.put(ACTION_SYNC_ACTIVITY_DATA, OtherDeviceProfile.ACTION_SYNC_ACTIVITY_DATA);
        constants.put(ACTION_SYNC_CONFIG, OtherDeviceProfile.ACTION_SYNC_CONFIG);
        constants.put(ACTION_SYNC_HEALTH_DATA, OtherDeviceProfile.ACTION_SYNC_HEALTH_DATA);
        constants.put(ACTION_SYNC_HEALTH_DATA_SPORT, OtherDeviceProfile.ACTION_SYNC_HEALTH_DATA_SPORT);
        constants.put(ACTION_SYNC_HEALTH_DATA_SLEEP, OtherDeviceProfile.ACTION_SYNC_HEALTH_DATA_SLEEP);
        constants.put(ACTION_SYNC_HEALTH_DATA_HEART_RATE, OtherDeviceProfile.ACTION_SYNC_HEALTH_DATA_HEART_RATE);
        constants.put(ACTION_SYNC_HEALTH_DATA_BLOOD_PRESSURE, OtherDeviceProfile.ACTION_SYNC_HEALTH_DATA_BLOOD_PRESSURE);

        constants.put(OPERATION_STATUS, OtherDeviceProfile.OPERATION_STATUS);
        constants.put(PROGRESS, OtherDeviceProfile.PROGRESS);

        constants.put("STATUS_START", 0);
        constants.put("STATUS_STOP", 1);
        constants.put("STATUS_DOING", 2);
        constants.put("STATUS_SUCCESS", 3);
        constants.put("STATUS_FAIL", 4);
        constants.put("STATUS_CANCEL", 5);

        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        return constants;
    }
}
