pragma solidity ^0.4.24;

contract BlockProof {
    Authority[] authorities;

    struct Authority {
        string name;
        uint256 authNumber;
        address owner;
        Software[] softwares;
    }

    struct Software {
        string name;
        uint256 softwareNumber;
        // mapping of softwareVersion to hashes
        mapping(string => string) hashes;
    }

    function registerNewAuthority(string authorityName)
        public
        returns (uint256 number)
    {
        uint256 authNumber = authorities.length;
        Authority authority;
        authority.name = authorityName;
        authority.authNumber = authNumber;
        authority.owner = msg.sender;
        authorities.push(authority);
        return authNumber;
    }

    function registerNewSoftware(uint256 authNumber, string softwareName)
        public
        returns (uint256 number)
    {
        uint256 newSoftwareNumber = authorities[authNumber].softwares.length;
        authorities[authNumber].softwares.push(
            Software(softwareName, newSoftwareNumber)
        );
        return newSoftwareNumber;
    }

    function addNewSoftwareVersion(
        uint256 authNumber,
        uint256 softwareNumber,
        string softwareVersion,
        string mewSoftwareHash
    ) public returns (bool sucessfull) {
        authorities[authNumber].softwares[softwareNumber].hashes[
                softwareVersion
            ] = mewSoftwareHash;
        return true;
    }

    function getSoftwareHash(
        uint256 authNumber,
        uint256 softwareNumber,
        string softwareVersion
    ) public view returns (string hash) {
        string storage _softwareHash = authorities[authNumber]
            .softwares[softwareNumber]
            .hashes[softwareVersion];
        return _softwareHash;
    }
}
