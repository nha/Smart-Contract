// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract PianoKingFunds is Ownable {
  using Address for address payable;

  address private firstDAO;
  address private secondDAO;

  /**
   * @dev Allow the contract to receive funds from anyone
   */
  receive() external payable {}

  function setDAOAddresses(address _firstDao, address _secondDao)
    external
    onlyOwner
  {
    require(
      _firstDao != address(0) && _secondDao != address(0),
      "Invalid address"
    );
    firstDAO = _firstDao;
    secondDAO = _secondDao;
  }

  function retrieveFunds() external onlyOwner {
    require(
      firstDAO != address(0) && secondDAO != address(0),
      "DAOs not active"
    );
    uint256 amountToSend = address(this).balance / 2;
    payable(firstDAO).sendValue(amountToSend);
    payable(secondDAO).sendValue(amountToSend);
  }
}
