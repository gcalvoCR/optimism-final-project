const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("GradeTrackerModule", (m) => {

  const gradeTracker = m.contract("GradeTracker", []);

  return { gradeTracker };
});