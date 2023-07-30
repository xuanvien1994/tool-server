const names = [
  "Vien",
  "Toan",
  "Quang",
  "Ánh",
  "Chuong",
  "Uyen",
  "Long",
  "Thuong",
  "Tin",
  "Hong",
  "Min",
  "Vien2",
];
let circleTable;

document.addEventListener("DOMContentLoaded", () => {
  circleTable = document.getElementById("circleTable");
  renderCircleTable();
});

function renderCircleTable() {
  circleTable.innerHTML = "";

  const radius = 120;
  const centerX = circleTable.clientWidth / 2;
  const centerY = circleTable.clientHeight / 2;
  const angleIncrement = (2 * Math.PI) / names.length;

  for (let i = 0; i < names.length; i++) {
    const angle = i * angleIncrement;
    const x = centerX + radius * Math.cos(angle);
    const y = centerY + radius * Math.sin(angle);

    const personDiv = document.createElement("div");
    personDiv.className = "person";
    personDiv.style.left = `${x - 20}px`;
    personDiv.style.top = `${y - 20}px`;
    personDiv.textContent = names[i];

    circleTable.appendChild(personDiv);
  }
}

function arrangeRandomly() {
  shuffleArray(names);
  setTimeout(() => {
    renderCircleTable();
  }, 100);
}

function shuffleArray(array) {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
}
