// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
interface IERC20 {
  function totalSupply() external view returns (uint256);

  function balanceOf(address who) external view returns (uint256);

  function allowance(address owner, address spender)
    external view returns (uint256);

  function transfer(address to, uint256 value) external returns (bool);

  function approve(address spender, uint256 value)
    external returns (bool);

  function transferFrom(address from, address to, uint256 value)
    external returns (bool);

  event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
  );

  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );
}

/**
 * @title PaymentSplitter
 * @dev This contract can be used when payments need to be received by a group
 * of people and split proportionately to some number of shares they own.
 */
contract PaymentSplitter {

  event PayeeAdded(address account, uint256 shares);
  event PaymentReleased(address to, address token, uint256 amount);

  uint256 _totalShares;
  mapping(address => uint256) _totalReleased;

  mapping(address => uint256) _shares;
  mapping(address => mapping(address => uint256)) _released;
  address[] _payees;

  /**
   * @dev Constructor
   */
  constructor(address[] memory payeesList, uint256[] memory sharesList) {
    require(payeesList.length == sharesList.length);
    require(payeesList.length > 0);

    for (uint256 i = 0; i < payeesList.length; i++) {
      _addPayee(payeesList[i], sharesList[i]);
    }
  }

  /**
   * @return the total shares of the contract.
   */
  function totalShares() external view returns(uint256) {
    return _totalShares;
  }

  /**
   * @return the total amount already released.
   */
  function totalReleased(address token) external view returns(uint256) {
    return _totalReleased[token];
  }

  /**
   * @return the shares of an account.
   */
  function shares(address account) external view returns(uint256) {
    return _shares[account];
  }

  /**
   * @return the amount already released to an account.
   */
  function released(address token, address account) external view returns(uint256) {
    return _released[token][account];
  }

  /**
   * @return the address of a payee.
   */
  function payee(uint256 index) external view returns(address) {
    return _payees[index];
  }

  /**
   * @dev Release one of the payee's proportional payment.
   * @param token Token to release from the contract.
   * @param account Whose payments will be released.
   */
  function release(address token, address account) external {
    require(_shares[account] > 0);

    uint256 totalReceived = IERC20(token).balanceOf(address(this)) + _totalReleased[token];
    uint256 payment = ((totalReceived * _shares[account]) / _totalShares) - _released[token][account];

    require(payment != 0);

    _released[token][account] = _released[token][account] + payment;
    _totalReleased[token] = _totalReleased[token] + payment;

    IERC20(token).transfer(account, payment);
    emit PaymentReleased(account, token, payment);
  }

  /**
   * @dev Add a new payee to the contract.
   * @param account The address of the payee to add.
   * @param shares_ The number of shares owned by the payee.
   */
  function _addPayee(address account, uint256 shares_) private {
    require(account != address(0));
    require(shares_ > 0);
    require(_shares[account] == 0);

    _payees.push(account);
    _shares[account] = shares_;
    _totalShares = _totalShares + shares_;
    emit PayeeAdded(account, shares_);
  }
}
