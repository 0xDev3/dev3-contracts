// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.4.2

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract SupplyChainManager {

    /*
        TYPES
    */
    
    enum State {
        EMPTY,
        PRODUCED,
        PACKED,
        SHIPPED,
        RECEIVED
    }

    struct User {
        address wallet;
        string info;
        State allowedToAdvance;
        uint256 addedAt;
        bool active;
    }

    struct StateChange {
        address changedBy;
        uint256 changedAt;
        State oldState;
        State newState;
        string note;
    }

    struct Product {
        uint256 id;
        string barcode;
        uint256 price;
        string description;
        State state;
    }

    /*
        STATE
    */

    address manager;
    address manufacturer;
    address paymentCurrency;
    User[] users;
    Product[] products;
    mapping(address => uint256) userIdMapping;
    mapping(string => bool) productExists;
    mapping(address => bool) userExists;
    mapping(string => StateChange[]) productHistory;
    mapping(address => StateChange[]) userHistory;

    /*
        CONSTRUCTOR
    */

    constructor(
        address _manager,
        address _manufacturer,
        address _paymentCurrency
    ) {
        manager = _manager;
        manufacturer = _manufacturer;
        paymentCurrency = _paymentCurrency;
    }

    /*
        MODIFIERS
    */

    modifier onlyManager() {
        require(
            msg.sender == manager,
            "Not manager!"
        );
        _;
    }

    modifier allowedToAdvance(State state) {
        require(
            userExists[msg.sender],
            "User not registered!"
        );
        require(
            users[userIdMapping[msg.sender]].active,
            "User deactivated!"
        );
        require(
            users[userIdMapping[msg.sender]].allowedToAdvance == state,
            "User missing role!"
        );
        _;
    }

    /*
        SUPPLY CHAIN MANAGEMENT
    */

    function setProduced(
        string memory barcode,
        uint256 price,
        string memory description,
        string memory note
    ) external allowedToAdvance(State.PRODUCED) {
        require(
            bytes(barcode).length > 0,
            "Barcode is empty!"
        );
        require(
            !productExists[barcode],
            "Barcode already exists!"
        );
        productExists[barcode] = true;
        Product memory product = Product(
            products.length,
            barcode,
            price,
            description,
            State.PRODUCED
        );
        StateChange memory stateChange = StateChange(
            msg.sender,
            block.timestamp,
            State.EMPTY,
            State.PRODUCED,
            note
        );
        productHistory[barcode].push(stateChange);
        userHistory[msg.sender].push(stateChange);
        products.push(product);
    }

    function setPacked(
        uint256 id,
        string memory note
    ) external allowedToAdvance(State.PACKED) {
        require(
            products[id].state == State.PRODUCED,
            "Invalid product state!"
        );
        StateChange memory stateChange = StateChange(
            msg.sender,
            block.timestamp,
            State.PRODUCED,
            State.PACKED,
            note
        );
        products[id].state = State.PACKED;
        productHistory[products[id].barcode].push(stateChange);
        userHistory[msg.sender].push(stateChange);
    }

    function setShipped(
        uint256 id,
        string memory note
    ) external allowedToAdvance(State.SHIPPED) {
        require(
            products[id].state == State.PACKED,
            "Invalid product state!"
        );
        StateChange memory stateChange = StateChange(
            msg.sender,
            block.timestamp,
            State.PACKED,
            State.SHIPPED,
            note
        );
        products[id].state = State.SHIPPED;
        productHistory[products[id].barcode].push(stateChange);
        userHistory[msg.sender].push(stateChange);
    }

    function setReceived(
        uint256 id,
        string memory note
    ) external allowedToAdvance(State.RECEIVED) {
        require(
            products[id].state == State.SHIPPED,
            "Invalid product state!"
        );
        StateChange memory stateChange = StateChange(
            msg.sender,
            block.timestamp,
            State.SHIPPED,
            State.RECEIVED,
            note
        );
        products[id].state = State.RECEIVED;
        productHistory[products[id].barcode].push(stateChange);
        userHistory[msg.sender].push(stateChange);
        IERC20(paymentCurrency).transfer(manufacturer, products[id].price);
    }

    /*
        USERS MANAGEMENT
    */

    function addUser(
        address wallet,
        string memory info,
        State role
    ) external onlyManager {
        require(
            !userExists[wallet],
            "User already exists!"
        );
        userExists[wallet] = true;
        userIdMapping[wallet] = users.length;
        User memory user = User(
            wallet,
            info,
            role,
            block.timestamp,
            true            
        );
        users.push(user);
    }

    function updateUserStatus(
        address wallet,
        bool active
    ) external onlyManager {
        require(
            userExists[wallet],
            "User does not exist"
        );
        users[userIdMapping[wallet]].active = active;
    }

    /*
        READ FUNCTIONS
    */

    function getUsers() external view returns (User[] memory) {
        return users;
    }

    function getProducts() external view returns (Product[] memory) {
        return products;
    }

    function getUserHistory(address user) external view returns (StateChange[] memory) {
        require(
            userExists[user],
            "User does not exist!"
        );
        return userHistory[user];
    }

    function getProductHistory(string memory barcode) external view returns (StateChange[] memory) {
        require(
            productExists[barcode],
            "Product does not exist!"
        );
        return productHistory[barcode];
    }

}
