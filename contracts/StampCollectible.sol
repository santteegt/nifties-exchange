pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Metadata.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721MetadataMintable.sol";

contract StampCollectible is ERC721MetadataMintable {

    struct Stamp {
        uint256 price;
        uint256 maxClones;
        uint256 inWild;
        uint256 clonedFrom;
    }

    uint256 public totalMinted;

    Stamp[] public stamps;

    uint256 public maxClones;

    uint8 constant private PRICEDEPTH = 255;
    uint256 constant private COSTMULTIPLIER = 1000000000000;

    mapping (address => mapping (uint256 => uint256)) public balances;

    event MintedStamp(uint256 tokenId, address owner, uint256 price);
    event NewStamp(uint256 tokenId, address owner, uint256 price);
    event BurnedStamp(uint256 tokenId, address owner);

    constructor(uint256 _maxClones) ERC721Metadata("CryptoStamps", "STAMPS") public {
    // function initialize(uint _maxClones) public initializer {
        maxClones = _maxClones;
        if(stamps.length == 0) {
            Stamp memory _dummy = Stamp({
                price: 0, maxClones: 0, inWild: 0, clonedFrom: 0});
            stamps.push(_dummy);
        }
    }

    function getNFTPrice(uint8 index) public view returns (uint16) {
        Stamp memory stamp = stamps[index];
        uint256 x = 0;
        for(uint8 depth=PRICEDEPTH;depth>0;depth--) {
          bytes32 blockHash = blockhash(block.number-depth);
          // uint16 thisBlockValue = uint16(convert(blockHash[index*2])) << 8 | uint16(convert(blockHash[index*2+1]));
          // x += uint256(thisBlockValue);
          x += convert(blockHash[index*2]) << 8 | convert(blockHash[index*2+1]);
        }
        return uint16(x/PRICEDEPTH) + uint16(stamp.inWild);
    }

    // function test(uint8 index) public view returns (bytes32) {
    //     for(uint8 depth=PRICEDEPTH;depth>0;depth--) {
    //       bytes32 blockHash = blockhash(block.number-depth);
    //       return blockHash[index*2];
    //     }
    // }
    //
    // function testdos(uint8 index) public view returns (uint) {
    //     for(uint8 depth=PRICEDEPTH;depth>0;depth--) {
    //       bytes32 blockHash = blockhash(block.number-depth);
    //       return convert(blockHash[index*2]);
    //     }
    // }
    //
    // function testtres(uint8 index) public view returns (uint16) {
    //     uint256 x = 0;
    //     for(uint8 depth=PRICEDEPTH;depth>0;depth--) {
    //       bytes32 blockHash = blockhash(block.number-depth);
    //       // uint16 thisBlockValue = convert(blockHash[index*2])) << 8 | convert(blockHash[index*2+1]);
    //       // return uint16(convert(blockHash[index*2]));
    //       x += convert(blockHash[index*2]) << 8 | convert(blockHash[index*2+1]);
    //     }
    //     // return uint16(x);
    //     return uint16(x/PRICEDEPTH);// + uint16(stamp.inWild);
    // }

    function convert(bytes32 b) public pure returns(uint) {
        return uint(b);
    }

    function mint(uint256 _priceFinney, string memory _tokenURI) public onlyMinter returns (bool) {
    // function mintStamp(uint256 _priceFinney) public onlyMinter returns (bool) {
        // uint16 price = getNFTPrice(_tokenURI);
        Stamp memory collectible = Stamp({
            price: _priceFinney * COSTMULTIPLIER,
            maxClones: maxClones,
            inWild: 0,
            clonedFrom: 0
        });
        uint256 tokenId = stamps.push(collectible) - 1;
        emit MintedStamp(tokenId, msg.sender, uint256(_priceFinney));
        totalMinted++;
        return mintWithTokenURI(msg.sender, tokenId, _tokenURI);
    }

    function buyStamp(uint256 _tokenId) public payable returns (bool) {
        Stamp memory stamp = stamps[_tokenId];
        require(stamp.inWild + 1 <= stamp.maxClones, "Max clones have been reached");
        require(msg.value >= stamp.price, "Not enough funds");
        stamp.inWild += 1;
        stamp.price = uint256(getNFTPrice(uint8(_tokenId))) * COSTMULTIPLIER;
        stamps[_tokenId] = stamp;

        // Stamp memory _newStamp;
        // _newStamp.price = stamp.priceFinney;
        // _newStamp.numClonesAllowed = 0;
        // _newStamp.numClonesInWild = 0;
        // _newStamp.clonedFromId = _tokenId;
        balances[msg.sender][_tokenId]++;

        emit NewStamp(_tokenId, msg.sender, stamp.price);
        return true;
    }

    function sellStamp(uint256 _tokenId) public returns (bool) {
        require(balances[msg.sender][_tokenId] > 0, "User does not own this stamp");
        balances[msg.sender][_tokenId]--;
        Stamp memory stamp = stamps[_tokenId];
        uint256 payout = stamp.price;
        stamp.inWild -= 1;
        stamp.price = uint256(getNFTPrice(uint8(_tokenId))) * COSTMULTIPLIER;
        stamps[_tokenId] = stamp;
        emit BurnedStamp(_tokenId, msg.sender);
        msg.sender.transfer(payout);
        return true;
    }

    function () external payable {
    }
}
