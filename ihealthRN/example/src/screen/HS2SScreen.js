import { Button, ListItem } from "@rneui/base";
import React, { useState, useEffect } from "react";
import { StyleSheet, TextInput, Text } from "react-native";
import hs2sAPI from "../api/hs2sAPI";

const HS2SScreen = ({ response, mac }) => {
	const [res, setRes] = useState(null);
	const [ready, setReady] = useState(false);
	const [data, setData] = useState({
		weight: null,
		age: null,
		height: null,
		gender: null,
	});

	const onGenderInput = (text) => {
		if (text.toLowerCase() === "male") setData({ ...data, gender: 1 });
		else if (text.toLowerCase() === "female") setData({ ...data, gender: 0 });
	};

	const onPress = () => {
		const fn = hs2sAPI.apis.measure;
		fn(mac, data.weight, data.age, data.height, data.gender);
	};

	useEffect(() => {
		if (response) {
			const r = JSON.parse(response);
			if ("data_body_fat_result" in r) {
				setReady(false);
				setRes(r);
			} else {
				setRes(null);
				setReady(true);
			}
		}
	}, [response]);

	return (
		<>
			<TextInput
				style={styles.input}
				placeholder="Weight"
				onChangeText={(val) => setData({ ...data, weight: Number(val) })}
			/>
			<TextInput
				style={styles.input}
				placeholder="Age"
				onChangeText={(val) => setData({ ...data, age: Number(val) })}
			/>
			<TextInput
				style={styles.input}
				placeholder="Height"
				onChangeText={(val) => setData({ ...data, height: Number(val) })}
			/>
			<TextInput
				style={styles.input}
				placeholder="Gender"
				onChangeText={onGenderInput}
			/>
			<Button
				onPress={onPress}
				disabled={
					!data.age ||
					(data.gender !== 0 && data.gender !== 1) ||
					!data.height ||
					!data.weight
				}
			>
				START MEASURE
			</Button>
			{ready && <Text style={{ fontSize: 20 }}>Starting measurement ...</Text>}
			{res && (
				<>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Weight: {res.data_body_fat_result.weight}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Protein rate: {res.data_body_fat_result.protein_rate}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Muscle mass: {res.data_body_fat_result.muscle_mas}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Body fit percentage:{" "}
								{res.data_body_fat_result.body_fit_percentage}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Body water rate: {res.data_body_fat_result.body_water_rate}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Physical age: {res.data_body_fat_result.physical_age}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Bone salt content: {res.data_body_fat_result.bone_salt_content}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
					<ListItem>
						<ListItem.Content>
							<ListItem.Title>
								Visceral fat grade:{" "}
								{res.data_body_fat_result.visceral_fat_grade}
							</ListItem.Title>
						</ListItem.Content>
					</ListItem>
				</>
			)}
		</>
	);
};

const styles = StyleSheet.create({
	input: {
		height: 40,
		margin: 12,
		borderWidth: 1,
		padding: 10,
	},
});

export default HS2SScreen;
