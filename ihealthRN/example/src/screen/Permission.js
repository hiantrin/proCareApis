import { Platform, PermissionsAndroid } from "react-native";
import iHealthAPI from "../api/iHealthAPI";
// import { useNavigation } from "@react-navigation/native";

const Permission = () => {
	// const navigation = useNavigation();

	const isAndroid = Platform.OS === "android";
	const version = Platform.Version;

	const requestPermission = (permissions) =>
		PermissionsAndroid.requestMultiple(permissions);

	if (isAndroid) {
		if (version < 31) {
			const permissions = [
				PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE,
				PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
				PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
				PermissionsAndroid.PERMISSIONS.ACCESS_COARSE_LOCATION,
			];
			requestPermission(permissions).then((granted) => {
				console.log(granted);
				iHealthAPI.sdkAuthWithLicense("com_procare_android.pem");
				// navigation.navigate("select");
			});
		} else {
			const permissions = [
				PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE,
				PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
				PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
				PermissionsAndroid.PERMISSIONS.ACCESS_COARSE_LOCATION,
				PermissionsAndroid.PERMISSIONS.BLUETOOTH_SCAN,
				PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT,
			];
			requestPermission(permissions).then((granted) => {
				console.log(granted);
				iHealthAPI.sdkAuthWithLicense("com_procare_android.pem");
				// navigation.navigate("Select");
			});
		}
	} else {
		// navigation.navigate("Select");
	}
};

export default Permission;
