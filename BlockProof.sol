// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockProof {
    Authority[] authorities;
    Software[] softwares;

    struct Authority {
        string name;
        uint256 authNumber;
        address owner;
    }

    struct Software {
        string name;
        uint256 softwareNumber;
        address owner;
        // mapping of softwareVersion to hashes
        mapping(string => string) hashes;
    }

    function registerNewAuthority(string memory authorityName)
        public
        returns (uint256 number)
    {
        uint256 authNumber = authorities.length;
        authorities.push(Authority(authorityName, authNumber, msg.sender));
        return authNumber;
    }

    function registerNewSoftware(uint256 authNumber, string memory softwareName)
        public
        returns (uint256 number)
    {
        if (authorities[authNumber].owner != msg.sender) {
            return 0;
        } else {
            uint256 newSoftwareNumber = softwares.length;
            Software storage software = softwares.push();
            software.name = softwareName;
            software.softwareNumber = newSoftwareNumber;
            software.owner = msg.sender;
            return newSoftwareNumber;
        }
    }

    function addNewSoftwareVersion(
        uint256 softwareNumber,
        string memory softwareVersion,
        string memory mewSoftwareHash
    ) public returns (bool sucessfull) {
        if (softwares[softwareNumber].owner == msg.sender) {
            softwares[softwareNumber].hashes[softwareVersion] = mewSoftwareHash;
            return true;
        }
        return false;
    }

    function getSoftwareHash(
        uint256 softwareNumber,
        string memory softwareVersion
    ) public view returns (string memory hash) {
        string storage _softwareHash = softwares[softwareNumber].hashes[
            softwareVersion
        ];
        return _softwareHash;
    }
}
