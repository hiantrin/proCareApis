import { Button, ListItem } from "@rneui/base";
import React, { useState, useEffect } from "react";
import kn550API from "../api/550btAPI";

const KN550Screen = ({ response, mac }) => {
	const [data, setData] = useState([]);
	const onPress = () => {
		const fn = Reflect.get(kn550API.apis, "getOffLineData", mac);
		fn(mac);
	};

	useEffect(() => {
		if (response) {
			const res = JSON.parse(response);
			if ("data" in res) {
				setData(res.data);
			}
		}
	}, [response]);

	return (
		<>
			<Button onPress={onPress} title="SEND RESULTS" />
			{data &&
				data.map((item) => (
					<>
						<ListItem>
							<ListItem.Content>
								<ListItem.Title>Heart rate: {item.heartRate}</ListItem.Title>
							</ListItem.Content>
						</ListItem>
						<ListItem>
							<ListItem.Content>
								<ListItem.Title>
									Body movement: {item.body_movement ? "YES" : "NO"}
								</ListItem.Title>
							</ListItem.Content>
						</ListItem>
						<ListItem>
							<ListItem.Content>
								<ListItem.Title>
									Arrhythmia: {item.arrhythmia ? "YES" : "NO"}
								</ListItem.Title>
							</ListItem.Content>
						</ListItem>
						<ListItem>
							<ListItem.Content>
								<ListItem.Title>
									Diastolic blood pressure: {item.dia}
								</ListItem.Title>
							</ListItem.Content>
						</ListItem>
						<ListItem>
							<ListItem.Content>
								<ListItem.Title>
									Systolic blood pressure: {item.sys}
								</ListItem.Title>
							</ListItem.Content>
						</ListItem>
					</>
				))}
		</>
	);
};

export default KN550Screen;
