// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract GradeTracker {
    
    // Address of the professor
    address public professor;
    
    // Name of the class
    string public className;
    
    // Constructor 
    constructor () {
        professor = msg.sender;
        className = "default";
    }
    
    // Mapping to relate the hash of the student's identity with their grade
    mapping (bytes32 => uint) Grades;
    
    // Array of students requesting grade reviews
    string[] reviews;

    // Mapping to store issued credentials
    mapping (bytes32 => bool) public credentials;
    
    // Events 
    event StudentGraded(bytes32);
    event ClassNameChanged(string);
    event ProfessorChanged(address);
    event ReviewEvent(string);
    event CredentialIssued(bytes32);
    
    // Modifiers
    modifier onlyProfessor(address _address) {
        // Requires that the address provided as parameter is equal to the contract owner
        require(_address == professor, "You do not have permission to execute this function.");
        _;
    }


    // Function to grade students
    function grade(string memory _studentId, uint _grade) public onlyProfessor(msg.sender) {
        // Hash of the student's identification
        bytes32 hash_studentId = keccak256(abi.encodePacked(_studentId));
        // Relationship between the student's identification hash and their grade
        Grades[hash_studentId] = _grade;
        // Emission of the event
        emit StudentGraded(hash_studentId);
    }
    
    
    // Function to view a student's grades
    function viewGrades(string memory _studentId) public view returns(uint) {
        // Hash of the student's identification
        bytes32 hash_studentId = keccak256(abi.encodePacked(_studentId));
        // Grade associated with the student's hash
        require(Grades[hash_studentId] != 0, "Student doesn't seem to have a grade");

        uint student_grade = Grades[hash_studentId];
        // Display the grade
        return student_grade;
    } 
    
    // Function to request an exam review
    function requestReview(string memory _studentId) public {
        // Store the student's identity in an array
        reviews.push(_studentId);
        // Emission of the event 
        emit ReviewEvent(_studentId);
    }
    
    // Function to view students who have requested exam reviews
    function viewReviews() public view onlyProfessor(msg.sender) returns (string[] memory) {
        // Return the identities of the students
        return reviews;
    }

    // Function to change the professor (the owner of the contract)
    function changeProfessor(address newProfessor) public onlyProfessor(msg.sender) {
        require(newProfessor != address(0), "New professor address cannot be the zero address.");
        professor = newProfessor;
        emit ProfessorChanged(newProfessor);
    }

    function changeClassName(string memory newClassName) public onlyProfessor(msg.sender) {
        className = newClassName;
        emit ClassNameChanged(newClassName);
    }

        // Function to issue a credential if the grade is higher than 70
    function issueCredential(string memory _studentId) public onlyProfessor(msg.sender) {
        // Hash of the student's identification
        bytes32 hash_studentId = keccak256(abi.encodePacked(_studentId));
        // Check if the grade is higher than 70
        require(Grades[hash_studentId] != 0, "The student has no grades registered");
        require(Grades[hash_studentId] > 70, "Grade is not high enough to issue a credential.");
        // Issue the credential
        credentials[hash_studentId] = true;
        // Emission of the event
        emit CredentialIssued(hash_studentId);
    }

    // Function to check if a credential has been issued
    function hasCredential(string memory _studentId) public view returns (bool) {
        // Hash of the student's identification
        bytes32 hash_studentId = keccak256(abi.encodePacked(_studentId));
        // Return if the credential has been issued
        require(Grades[hash_studentId] != 0, "The student has no grades registered");

        return credentials[hash_studentId];
    }

    function checkIfStudentHasGrade(string memory _studentId) public view returns (bool) {
        // Hash of the student's identification
        bytes32 hash_studentId = keccak256(abi.encodePacked(_studentId));
        return Grades[hash_studentId] != 0;
    }
}
