import { Button, ListItem } from "@rneui/base";
import React from "react";
import po3API from "../api/po3API";

const PO3Screen = ({ response, mac }) => {
	const onPress = () => {
		const fn = Reflect.get(po3API.apis, "startMeasure", mac);
		fn(mac);
	};

	return (
		<>
			<Button onPress={onPress} title="START" />
			{response && (
				<>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Heart rate: {JSON.parse(response)?.heartrate}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Blood oxygen: {JSON.parse(response)?.bloodoxygen}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Pulse strength: {JSON.parse(response)?.pulsestrength}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>PI: {JSON.parse(response)?.pi}</ListItem.Title>
						</ListItem.Content>
					</ListItem>
				</>
			)}
		</>
	);
};

export default PO3Screen;
