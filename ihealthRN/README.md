# iHealth react native SDK

## Release note

### V1.6.0
1. Support new devices AM6
2. Support KN550-BT latest firmware 2.0.1. API changes in detail please refer to https://chenxuewei-ihealth.github.io/ihealthlabs-sdk-docs/docs/react-native/blood_pressure/kn550
3. Fixed BG5S and KN550-BT issues directly without scanning. BG5S and KN550-BT (2.0.0) use the same UUID. If the direct connection cannot determine the device type without scanning, the parameter passed by the caller is read to determine the type(Android).
4. Support PO3 latest firmware 3.1.1. Limit PO3 PI range from 0.2 to 20 API changes in detail please refer to https://chenxuewei-ihealth.github.io/ihealthlabs-sdk-docs/docs/react-native/blood_oxygen/po3
