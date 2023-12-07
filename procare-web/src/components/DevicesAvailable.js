import { Dialog } from "@headlessui/react";
import { XIcon } from "@heroicons/react/outline";
import { Transition } from "@windmill/react-ui";
import { useAtom } from "jotai";
import { Fragment, useEffect, useState } from "react";
import { io } from "socket.io-client";
import { device as deviceAtom } from "../state/device";

const socket = io("ws://15.237.182.124:3000");

const DevicesAvailable = ({ open, type, handleClose }) => {
  const [device, setDevice] = useAtom(deviceAtom);
  const [devices, setDevices] = useState([]);
  const [isLoading, setLoading] = useState(true);
  const [isConnecting, setConnecting] = useState(false);
  const [isDisconnecting, setDisconnecting] = useState(false);

  useEffect(() => {
    socket.on("scanned-devices-bst", (data) => {
      console.log("scanned device", { data, type });
      if (data.length) {
        setLoading(false);
        setDevices(data.map((item) => item.mac));
      }
    });

    socket.on("connected-device-bst", (data) => {
      console.log("connected device", { data });
      setConnecting(false);
      if (data.onConnectedState?.mac) {
        setDevice({
          ...data.onConnectedState,
          state: "connected",
        });
      }
    });

    socket.on("disconnected-device-bst", (data) => {
      console.log("disconnected device", { data });
      setDisconnecting(false);
      if (data.onDisConnectState?.mac) {
        setDevice({
          mac: "",
          type: "",
          state: "stale",
        });
      }
    });
  }, []);

  const onConnectDevice = (device) => {
    setConnecting(true);
    socket.emit("connect-device", { mac: device, type });
  };

  const onDisconnectDevice = (device) => {
    setDisconnecting(true);
    socket.emit("disconnect-device", { mac: device, type });
  };

  console.log({ device });

  return (
    <Dialog
      as="div"
      className="relative z-10 "
      open={open}
      onClose={() => {
        setDevices([]);
        setLoading(true);
        handleClose();
      }}
    >
      {/* <Transition.Child
        as={Fragment}
        enter="ease-out duration-300"
        enterFrom="opacity-0"
        enterTo="opacity-100"
        leave="ease-in duration-200"
        leaveFrom="opacity-100"
        leaveTo="opacity-0"
      >
        <div className="fixed inset-0 bg-black bg-opacity-25" /> */}
      {/* </Transition.Child> */}
      <div className="fixed inset-0 overflow-y-auto ">
        <div className="flex min-h-full items-center justify-center p-4 text-center ">
          {/* <Transition.Child
            as={Fragment}
            enter="ease-out duration-300"
            enterFrom="opacity-0 scale-95"
            enterTo="opacity-100 scale-100"
            leave="ease-in duration-200"
            leaveFrom="opacity-100 scale-100"
            leaveTo="opacity-0 scale-95"
          > */}
          <Dialog.Panel className="w-full max-w-2xl transform overflow-hidden rounded bg-gray-750 p-6 text-center align-middle shadow-xl transition-all border border-solid border-neutral-600">
            <Dialog.Title
              as="h5"
              className="text-lg font-medium leading-6 text-white mb-4"
            >
              Devices
            </Dialog.Title>
            <div className="border-t border-solid border-neutral-600" />
            <div className="flex flex-1  flex-col overflow-hidden bg-gray-750  xl:p-[2px] lg:p-[5px] p-[2px]">
              <div className="flex items-center justify-center">
                <div className="absolute top-2 right-2 focus-visible:border-none">
                  <button
                    onClick={() => {
                      setDevices([]);
                      setLoading(true);
                      handleClose();
                    }}
                    className="focus-visible:border-none"
                  >
                    <XIcon className="h-6 w-6 text-white" />
                  </button>
                </div>
              </div>
              <div className="mt-10">
                {device.state === "connected" ? (
                  <div className="flex justify-between align-center">
                    <label className="font-medium text-white">
                      {device.mac}
                    </label>
                    <button
                      className="flex items-center justify-between text-white w-full border border-gray-300 rounded py-3 px-2"
                      style={{ width: "110px" }}
                      onClick={() => onDisconnectDevice(device.mac)}
                    >
                      Disconnect
                    </button>
                  </div>
                ) : isLoading ? (
                  <div role="status" className="flex justify-center">
                    <svg
                      aria-hidden="true"
                      class="w-8 h-8 mr-2 text-gray-200 animate-spin dark:text-gray-600 fill-blue-500"
                      viewBox="0 0 100 101"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                        fill="currentColor"
                      />
                      <path
                        d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                        fill="currentFill"
                      />
                    </svg>
                    <span class="sr-only">Loading...</span>
                  </div>
                ) : (
                  devices.map((item, index) => (
                    <div
                      key={index}
                      className="flex justify-between align-center"
                    >
                      <div onClick={() => onConnectDevice(item)}>
                        <label className="font-medium text-white cursor-pointer">
                          {item}
                        </label>
                      </div>
                      {isConnecting && (
                        <label className="font-small text-white cursor-pointer">
                          connecting ..
                        </label>
                      )}
                      {isDisconnecting && (
                        <label className="font-small text-white cursor-pointer">
                          disconnecting ..
                        </label>
                      )}
                    </div>
                  ))
                )}
              </div>
            </div>
          </Dialog.Panel>
          {/* </Transition.Child> */}
        </div>
      </div>
    </Dialog>
  );
};

export default DevicesAvailable;
