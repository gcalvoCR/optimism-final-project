// SPDX-License-Identifier: MITs
pragma solidity ^0.8.24;

contract CredentialRegistry {

    // struct para cada uno de los credenciales
    struct Credential {
        string issuer;          // instución que acredita
        string credentialName;  // nombre del credencial, por ejemplo AWS cloud practitioner
        string credentialUrl;   // url del credencial, a veces existen esas credenciales
        uint256 issueDate;      // dia en que lo entregaron
        uint256 expirationDate; // dia en que caduca el credencial
    }

    // lista de credenciales por "persona"
    mapping(address => Credential[]) public userCredentials;

    // diccionario de validadores
    mapping(address => bool) public validators;
    
    // Gabriel, Andrey o Kun
    address public owner;

    // para eventualmente interactuar con el front-end
    event CredentialIssued(
        address indexed user, 
        string issuer, 
        string credentialName, 
        string credentialUrl, 
        uint256 issueDate,
        uint256 expirationDate);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyValidator() {
        require(validators[msg.sender], "Only validators can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addValidator(address _validator) public onlyOwner {
        validators[_validator] = true;
    }

    function removeValidator(address _validator) public onlyOwner {
        validators[_validator] = false;
    }

    function issueCredential(
        address _user, 
        string memory _issuer, 
        string memory _credentialName, 
        string memory _credentialUrl, 
        uint256 _issueDate,
        uint256 _expirationDate
    ) public onlyValidator {
        require(_expirationDate > _issueDate, "Expiration date must be after issue date");

        Credential memory newCredential = Credential({
            issuer: _issuer,
            credentialName: _credentialName,
            credentialUrl: _credentialUrl,
            issueDate: _issueDate,
            expirationDate: _expirationDate
        });

        userCredentials[_user].push(newCredential);
        emit CredentialIssued(_user, _issuer, _credentialName, _credentialUrl, _issueDate, _expirationDate);
    }

    function getUserCredentials(address _user) public view returns (Credential[] memory) {
        return userCredentials[_user];
    }

    function isCredentialValid(address _user, uint256 _index) public view returns (bool) {
        require(_index < userCredentials[_user].length, "Error getting credentials");

        Credential memory credential = userCredentials[_user][_index];
        return block.timestamp < credential.expirationDate;
    }

    // Funcionalidad adicional para transferir el ownership si alguno se da de baja
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

}