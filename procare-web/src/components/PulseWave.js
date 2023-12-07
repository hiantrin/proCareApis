import React from "react";
import { Line } from "react-chartjs-2";

const PulseWaveChart = ({ data }) => {
  const chartData = {
    labels: data.map((entry, index) => index + 1),
    datasets: [
      {
        label: "Pulse Wave",
        data: data.map((entry) => entry.pulseWave[0]),
        fill: false,
        borderColor: "rgb(75, 192, 192)",
        tension: 0.1,
      },
    ],
  };

  return (
    <div style={{ maxWidth: "600px", margin: "0 auto" }}>
      <Line data={chartData} />
    </div>
  );
};

export default PulseWaveChart;
