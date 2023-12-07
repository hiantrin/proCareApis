package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg1aProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "BG1AProfileModule")
public class BG1AProfileModule extends ReactContextBaseJavaModule {
    
    private static final String name = BG1AProfileModule.class.getSimpleName();

    /**
     * The action type of callback indicating the error of BG1A device.
     * The 
     */
    String ACTION_ERROR_BG1A = "action_error";
    
    /**
     * error code
     */
    String ERROR_NUM_BG1A = "error_num";
    
    /**
     * error description
     */
    String ERROR_DESCRIPTION_BG1A = "error_description";

    /**
     * The action type of callback indicating set mode of measure.
     */
    String ACTION_SET_MEASURE_MODE = "action_set_measure_mode";

    /**
     * The power of Battery for BG1A device.
     */
    String INFO_BATTERY_BG1A = "battery";
    
    /**
     * The action type of callback indicating blood drop detected.
     */
    String ACTION_GET_BLOOD = "action_get_blood";

    /**
     * The action type of callback indicating insertion status of test strip.
     * <ul>
     * <li>1: strip in</li>
     * <li>2: strip out</li>
     * </ul>
     */
    String ACTION_STRIP_INSERTION_STATUS = "action_strip_insertion_status";

    /**
     * The insertion status of test strip
     */
    String STRIP_INSERTION_STATUS = "insertion_status";

    /**
     * The code type
     */
    String STRIP_CODE_TYPE = "strip_code_type";

    /**
     * The action type of callback indicating result of measure.
     */
    String ACTION_MEASURE_RESULT = "action_measure_result";
    
    /**
     * The mode of measure
     */
    String MEASURE_MODE = "measure_mode";
    
    /**
     * The result of measure
     */
    String MEASURE_RESULT = "measure_result";

    /**
     * The status of operation
     */
    String OPERATION_STATUS = "status";

    /**
     * The describe of operation
     */
    String OPERATION_DESCRIBE = "describe";

    /**
     * The result of check the blood code
     * <ul>
     * <li>0: check the blood code is success</li>
     * <li>other: check the blood code is fail</li>
     * </ul>
     */
    String BLOOD_CHECK_CODE_RESULT = "blood_check_code_result";

    /**
     * The action for set device code from BG1A
     */
    String ACTION_SET_DEVICE_CODE = "action_set_device_code";

    /**
     * The action for get device code from BG1A
     */
    String ACTION_GET_DEVICE_CODE = "action_get_device_code";

    /**
     *
     */
    String ACTION_GET_DEVICE_INFO = "action_get_device_info";

    String ACTION_SET_DEVICE_TIME = "action_set_device_time";

    String MEASURE_TIME_IS_ERROR = "measure_time_is_error";
    String MEASURE_TIME_DEVICE = "measure_time_device";
    String ACTION_MEASURE_RESULT_HISTORY = "action_measure_result_history";
    String ACTION_DELETE_HISTORY_RESULT = "action_delete_history_result";
    String INFO_HISTORY_STATUS_BG1A = "info_history_status_bg1a";
    String INFO_LOCAL_TIME = "info_local_time";
    String STRIP_TYPE = "type";
    /**
     * @return the name of this module. This will be the name used to {@code require()} this module
     * from javascript.
     */
    @Override
    public String getName() {
        return name;
    }

    public BG1AProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    /**
     * @return a map of constants this module exports to JS. Supports JSON types.
     */
    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> constants = new HashMap<>();

        constants.put(ACTION_ERROR_BG1A, Bg1aProfile.ACTION_ERROR_BG1A);
        constants.put(ERROR_NUM_BG1A, Bg1aProfile.ERROR_NUM_BG1A);
        constants.put(ERROR_DESCRIPTION_BG1A, Bg1aProfile.ERROR_DESCRIPTION_BG1A);

        constants.put(ACTION_GET_DEVICE_INFO, Bg1aProfile.ACTION_GET_DEVICE_INFO);
        
        constants.put(INFO_BATTERY_BG1A, Bg1aProfile.INFO_BATTERY_BG1A);

        constants.put(ACTION_SET_MEASURE_MODE, Bg1aProfile.ACTION_SET_MEASURE_MODE);

        constants.put(ACTION_GET_BLOOD, Bg1aProfile.ACTION_GET_BLOOD);
        constants.put(ACTION_STRIP_INSERTION_STATUS, Bg1aProfile.ACTION_STRIP_INSERTION_STATUS);
        constants.put(STRIP_INSERTION_STATUS, Bg1aProfile.STRIP_INSERTION_STATUS);
        constants.put(STRIP_CODE_TYPE, Bg1aProfile.STRIP_CODE_TYPE);

        constants.put(ACTION_MEASURE_RESULT, Bg1aProfile.ACTION_MEASURE_RESULT);
        constants.put(MEASURE_MODE, Bg1aProfile.MEASURE_MODE);
        constants.put(MEASURE_RESULT, Bg1aProfile.MEASURE_RESULT);

        constants.put(OPERATION_STATUS, Bg1aProfile.OPERATION_STATUS);
        constants.put(OPERATION_DESCRIBE, Bg1aProfile.OPERATION_DESCRIBE);

        constants.put(ACTION_SET_DEVICE_CODE, Bg1aProfile.ACTION_SET_DEVICE_CODE);
        constants.put(ACTION_GET_DEVICE_CODE, Bg1aProfile.ACTION_GET_DEVICE_CODE);

        constants.put(ACTION_SET_DEVICE_TIME, Bg1aProfile.ACTION_SET_DEVICE_TIME);
        constants.put(MEASURE_TIME_IS_ERROR, Bg1aProfile.MEASURE_TIME_IS_ERROR);
        constants.put(MEASURE_TIME_DEVICE, Bg1aProfile.MEASURE_TIME_DEVICE);
        constants.put(ACTION_MEASURE_RESULT_HISTORY, Bg1aProfile.ACTION_MEASURE_RESULT_HISTORY);
        constants.put(ACTION_DELETE_HISTORY_RESULT, Bg1aProfile.ACTION_DELETE_HISTORY_RESULT);
        constants.put(INFO_HISTORY_STATUS_BG1A, Bg1aProfile.INFO_HISTORY_STATUS_BG1A);
        constants.put(INFO_LOCAL_TIME, Bg1aProfile.INFO_LOCAL_TIME);
        constants.put(STRIP_TYPE, Bg1aProfile.STRIP_TYPE);


        return constants;
    }
}
