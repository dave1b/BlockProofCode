// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockProof {
    mapping(address => Authority) authorities;
    Software[] softwares;

    struct Authority {
        string name;
        address owner;
    }

    struct Software {
        string name;
        uint256 softwareNumber;
        address owner;
        // mapping of softwareVersion to hashes
        mapping(string => string) hashes;
    }

    event NewSoftware(address indexed owner, uint256 softwareNumber);

    function registerNewAuthority(string memory authorityName) public {
        authorities[msg.sender] = (Authority(authorityName, msg.sender));
    }

    function registerNewSoftware(string memory softwareName) public {
        uint256 newSoftwareNumber = softwares.length;
        Software storage software = softwares.push();
        software.name = softwareName;
        software.softwareNumber = newSoftwareNumber;
        software.owner = msg.sender;
        emit NewSoftware(msg.sender, newSoftwareNumber);
    }

    function addNewSoftwareVersion(
        uint256 softwareNumber,
        string memory softwareVersion,
        string memory mewSoftwareHash
    ) public {
        if (softwares[softwareNumber].owner == msg.sender) {
            softwares[softwareNumber].hashes[softwareVersion] = mewSoftwareHash;
        }
    }

    function getSoftwareHash(
        uint256 softwareNumber,
        string memory softwareVersion
    ) public view returns (string memory hash) {
        string memory _softwareHash = softwares[softwareNumber].hashes[
            softwareVersion
        ];
        return _softwareHash;
    }
}
