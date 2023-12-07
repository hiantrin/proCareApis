import React, { useEffect, useState } from 'react'
import { View, StyleSheet, DeviceEventEmitter } from 'react-native'
import { Button, ListItem } from '@rneui/themed';
import { useRecoilValue, useSetRecoilState } from 'recoil';
import useScanAPI from '../api/useScanAPI';
import useConnectAPI  from '../api/useConnectAPI';
import store from '../store';

const ScanScreen = ({ navigation, route }) => {
  
  const {onScanState, isScanning, scanDevice} = useScanAPI();
  const {onConnectedState, onConnectFailState, onDisConnectState, connectDevice} = useConnectAPI();
  const [scanDevices, setScanDevices] = useState([]);

  const handleScan = (type) => {
    setScanDevices([]);
    scanDevice(type);
  }

  useEffect(() => {
    if (onConnectedState.mac != null) {
      const {mac, type} = onConnectedState;
      navigation.navigate('Device', {
        mac, type
      });
    }
  }, [onConnectedState]);

  useEffect(() => {
    if (onScanState.mac != null) {
      setScanDevices([
        ...scanDevices,
        onScanState
      ])
    }
  }, [onScanState])

  return (
    <View>
      <Button
        containerStyle={styles.containerStyle}  
        buttonStyle={styles.buttonStyle} 
        title="Scan Device"
        loading={isScanning} 
        onPress={() => {
          handleScan(route.params.type);
        }} />
        {
        scanDevices.map(item => {
          return (
            <ListItem
              key={item.mac}
              onPress={() => {  
                connectDevice(item.mac, item.type);
              }}
              bottomDivider>
              <ListItem.Content>
                <ListItem.Title>{item.mac}</ListItem.Title>
              </ListItem.Content>
              <ListItem.Chevron />
            </ListItem>
          )
          })
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

export default ScanScreen
