# Optimism Final Project

<p align="center">
  <a href="https://www.optimism.io/" target="blank"><img src="https://avatars.githubusercontent.com/u/58791460?v=4" width="300" alt="Optimism Logo" /></a>
</p>

This repository contains the final project for the [Optimism University module held at CENFOTEC University in Costa Rica](https://gov.optimism.io/t/optimism-university-module-in-costa-rica/8338). This intensive 7-week program, focusing on Blockchain, Web3, and Optimism technologies, equips students with comprehensive knowledge and hands-on experience. 




## Developers
* **Gabriel Calvo Vargas** - [gCalvoCR](https://github.com/gcalvoCR)
* **Kun Zheng** - [kunZhen](https://github.com/kunZhen)
* **Andrey Melendez** - [4ndreyMS](https://github.com/4ndreyMS)

## Structure
The project has 2 parts:

A backend with the contract
A frontend with the graphical interface that will eventually consume the created contract.

## Functionality

The GradeTracker smart contract provides a system for managing student grades, issuing credentials, and handling review requests. Below is an overview of its key functionalities:

### Main Features

- Grade Students: Professors can assign grades to students using the grade function. The student's ID is hashed and the grade is stored in the Grades mapping.
View Grades: Anyone can view a student's grade by calling the viewGrades function, which retrieves the grade associated with the student's ID hash.
Review Requests

- Request Review: Students can request a review of their exam by calling the requestReview function. This adds their ID to the reviews array.
View Review Requests: Professors can view all review requests by calling the viewReviews function.
Credential Issuance

- Issue Credential: Professors can issue credentials to students if their grade is higher than 70. This is done using the issueCredential function, which updates the credentials mapping.
Check Credential: Anyone can check if a student has been issued a credential by calling the hasCredential function.
Administrative Functions

- Change Professor: The current professor (contract owner) can transfer ownership to a new address using the changeProfessor function.
Change Class Name: The professor can update the class name with the changeClassName function.

### Events
- StudentGraded(bytes32): Emitted when a grade is assigned to a student.
- ClassNameChanged(string): Emitted when the class name is updated.
- ProfessorChanged(address): Emitted when the professor (contract owner) changes.
- ReviewEvent(string): Emitted when a student requests an exam review.
- CredentialIssued(bytes32): Emitted when a credential is issued to a student.

### Modifiers
- onlyProfessor(address _address): Ensures that only the professor can execute specific functions.

This contract allows for a structured approach to grading, reviewing, and credentialing students while providing administrative control to the contract's owner.