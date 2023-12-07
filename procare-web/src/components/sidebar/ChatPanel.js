import { PaperAirplaneIcon } from "@heroicons/react/solid";
import { useMeeting, usePubSub } from "@videosdk.live/react-sdk";
import React, { useEffect, useRef, useState } from "react";
import { formatAMPM, json_verify, nameTructed } from "../../utils/helper";
import { io } from "socket.io-client";
import { device as deviceAtom } from "../../state/device";
import { useAtom } from "jotai";

const socket = io("ws://15.237.182.124:3000");

const ChatMessage = ({ senderId, senderName, text, timestamp }) => {
  const mMeeting = useMeeting();
  const localParticipantId = mMeeting?.localParticipant?.id;
  const localSender = localParticipantId === senderId;

  return (
    <div
      className={`flex ${localSender ? "justify-end" : "justify-start"} mt-4`}
      style={{
        maxWidth: "100%",
      }}
    >
      <div
        className={`flex ${
          localSender ? "items-end" : "items-start"
        } flex-col py-1 px-2 rounded-md bg-gray-700`}
      >
        <p style={{ color: "#ffffff80" }}>
          {localSender ? "You" : nameTructed(senderName, 15)}
        </p>
        <div>
          <p className="inline-block whitespace-pre-wrap break-words text-right text-white">
            {text}
          </p>
        </div>
        <div className="mt-1">
          <p className="text-xs italic" style={{ color: "#ffffff80" }}>
            {formatAMPM(new Date(timestamp))}
          </p>
        </div>
      </div>
    </div>
  );
};

const ChatInput = ({ inputHeight }) => {
  const [message, setMessage] = useState("");
  const { publish } = usePubSub("CHAT");
  const input = useRef();

  return (
    <div
      className="w-full flex items-center px-2"
      style={{ height: inputHeight }}
    >
      <div class="relative  w-full">
        <span class="absolute inset-y-0 right-0 flex mr-2 rotate-90 ">
          <button
            disabled={message.length < 2}
            type="submit"
            className="p-1 focus:outline-none focus:shadow-outline"
            onClick={() => {
              const messageText = message.trim();
              if (messageText.length > 0) {
                publish(messageText, { persist: true });
                setTimeout(() => {
                  setMessage("");
                }, 100);
                input.current?.focus();
              }
            }}
          >
            <PaperAirplaneIcon
              className={`w-6 h-6 ${
                message.length < 2 ? "text-gray-500 " : "text-white"
              }`}
            />
          </button>
        </span>
        <input
          type="text"
          className="py-4 text-base text-white bg-gray-750 rounded pr-10 focus:outline-none w-full"
          placeholder="Write your message"
          autocomplete="off"
          ref={input}
          value={message}
          onChange={(e) => {
            setMessage(e.target.value);
          }}
          onKeyPress={(e) => {
            if (e.key === "Enter" && !e.shiftKey) {
              e.preventDefault();
              const messageText = message.trim();

              if (messageText.length > 0) {
                publish(messageText, { persist: true });
                setTimeout(() => {
                  setMessage("");
                }, 100);
                input.current?.focus();
              }
            }
          }}
        />
      </div>
    </div>
  );
};

//"{"pi":4.699999809265137,"pulsestrength":0,"pulseWave":[0,0,747],"action":"liveData_po","type":"PO3","heartrate":61,"bloodoxygen":99,"mac":"FC45C322E29C"}"

const ChatMessages = ({ listHeight }) => {
  const [device] = useAtom(deviceAtom);
  const [data, setData] = useState(null);
  const listRef = useRef();
  const { messages } = usePubSub("CHAT");

  const scrollToBottom = (data) => {
    if (!data) {
      if (listRef.current) {
        listRef.current.scrollTop = listRef.current.scrollHeight;
      }
    } else {
      const { text } = data;

      if (json_verify(text)) {
        const { type } = JSON.parse(text);
        if (type === "CHAT") {
          if (listRef.current) {
            listRef.current.scrollTop = listRef.current.scrollHeight;
          }
        }
      }
    }
  };

  useEffect(() => {
    socket.on("device-response-bst", (data) => {
      console.log("device response", { data });
      if (data.type === "KN550") {
        const res = JSON.parse(data.response);
        if ("data" in res)
          setData({
            ...data,
            response: res,
          });
      } else if (data.type === "HS2S") {
        const res = JSON.parse(data.response);
        if ("data_body_fat_result" in res) setData(res);
      } else {
        setData({
          ...data,
          response: JSON.parse(data.response),
        });
      }
    });
  }, []);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  return messages ? (
    <div ref={listRef} style={{ overflowY: "scroll", height: listHeight }}>
      <div className="p-3">
        {data && (
          <div className="flex-col py-1 px-2 rounded-md bg-gray-500">
            <>
              <div>
                <p className="inline-block whitespace-pre-wrap break-words text-white">
                  Data coming from device
                </p>
              </div>
              {data.type === "PO3" && (
                <>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Heart rate: {data.response.heartrate}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Blood oxygen: {data.response.bloodoxygen}
                    </p>
                  </div>
                  {/* <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Pulse wave: {data.response.pulseWave}
                    </p>
                  </div> */}
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Pulse strength: {data.response.pulsestrength}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      PI: {data.response.pi}
                    </p>
                  </div>
                </>
              )}
              {data.type === "KN550" &&
                data.response.data.map((item, index) => (
                  <div key={index} className="mt-4 border-top-1">
                    <div>
                      <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                        Heart rate: {item.heartRate}
                      </p>
                    </div>
                    <div>
                      <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                        Body movement: {item.body_movement ? "YES" : "NO"}
                      </p>
                    </div>
                    <div>
                      <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                        Arrhythmia: {item.arrhythmia ? "YES" : "NO"}
                      </p>
                    </div>
                    <div>
                      <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                        Diastolic blood pressure: {item.dia}
                      </p>
                    </div>
                    <div>
                      <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                        Systolic blood pressure: {item.sys}
                      </p>
                    </div>
                  </div>
                ))}

              {data.type === "HS2S" && (
                <>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Weight: {data.data_body_fat_result.weight}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Protein rate: {data.data_body_fat_result.protein_rate}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Muscle mass: {data.data_body_fat_result.muscle_mas}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Body fit percentage:{" "}
                      {data.data_body_fat_result.body_fit_percentage}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Body water rate:{" "}
                      {data.data_body_fat_result.body_water_rate}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Physical age: {data.data_body_fat_result.physical_age}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Bone salt content:{" "}
                      {data.data_body_fat_result.bone_salt_content}
                    </p>
                  </div>
                  <div>
                    <p className="inline-block whitespace-pre-wrap break-words text-white mt-5">
                      Visceral fat grade:{" "}
                      {data.data_body_fat_result.visceral_fat_grade}
                    </p>
                  </div>
                </>
              )}
            </>
          </div>
        )}
      </div>
      <div className="p-4">
        {messages.map((msg, i) => {
          const { senderId, senderName, message, timestamp } = msg;
          return (
            <ChatMessage
              key={`chat_item_${i}`}
              {...{ senderId, senderName, text: message, timestamp }}
            />
          );
        })}
      </div>
    </div>
  ) : (
    <p>No messages</p>
  );
};

export function ChatPanel({ panelHeight }) {
  const inputHeight = 72;
  const listHeight = panelHeight - inputHeight;

  return (
    <div>
      <ChatMessages listHeight={listHeight} />
      <ChatInput inputHeight={inputHeight} />
    </div>
  );
}
