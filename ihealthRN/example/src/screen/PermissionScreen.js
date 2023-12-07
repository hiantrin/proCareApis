import React from 'react';
import { Platform, PermissionsAndroid, StyleSheet } from 'react-native';
import { Button } from '@rneui/themed';
import { View  } from 'react-native';
import iHealthAPI from '../api/iHealthAPI';

const PermissionScreen = ({ navigation }) => {
  
  const isAndroid = Platform.OS === 'android'
  const version  = Platform.Version

  const requestPermission = (permissions) => PermissionsAndroid.requestMultiple(permissions)

  const handlePress = () => {
    if (isAndroid) {
      if (version < 31) {
        const permissions = [
          PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE,
          PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
          PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
          PermissionsAndroid.PERMISSIONS.ACCESS_COARSE_LOCATION
        ]
        requestPermission(permissions).then((granted) => {
          console.log(granted)
          iHealthAPI.sdkAuthWithLicense('com_procare_android.pem');
          navigation.navigate('Select');
        })
      } else {
        const permissions = [
          PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE,
          PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
          PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
          PermissionsAndroid.PERMISSIONS.ACCESS_COARSE_LOCATION,
          PermissionsAndroid.PERMISSIONS.BLUETOOTH_SCAN,
          PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT
        ]
        requestPermission(permissions).then((granted) => {
          console.log(granted)
          iHealthAPI.sdkAuthWithLicense('com_procare_android.pem');
          navigation.navigate('Select');
        })
      }
    } else {
      navigation.navigate('Select');
    }
  }

  return (
    <View>
      {
        isAndroid 
          ? <Button
              containerStyle={styles.containerStyle}  
              buttonStyle={styles.buttonStyle} 
              title="check license and permission" 
              onPress={handlePress} /> 
          : <Button
              containerStyle={styles.containerStyle}   
              buttonStyle={styles.buttonStyle} 
              title="check license"  
              onPress={handlePress} />
      }
    </View>
  )
}

const styles = StyleSheet.create({
  containerStyle: {
    width: '50%',
    marginHorizontal: 10,
    marginVertical: 10,
  },
  buttonStyle: {
    backgroundColor: '#2089dc',
    borderColor: 'transparent',
    borderWidth: 0,
    borderRadius: 10,
  }
})

export default PermissionScreen