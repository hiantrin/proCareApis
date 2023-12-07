import { atom } from "jotai";

export const device = atom({
  mac: "",
  type: "",
  state: "stale",
});
