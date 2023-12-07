import { atom, selector } from 'recoil';

const connected = atom({
    key: 'connection',
    default: false
})

const isConnected = selector({
    key: 'isConnected',
    get: ({ get }) => get(connected)
})

const connectedDevice = atom({
    key: 'connectedDevice',
    default: {},
})

export default {
    connected,
    isConnected,
    connectedDevice,
}
