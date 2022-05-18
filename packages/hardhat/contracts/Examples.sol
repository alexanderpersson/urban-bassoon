// Which version of the compiler code is built against
pragma solidity >=0.8.0 <0.9.0;

// Importing a package, in this case console
import "hardhat/console.sol";

// A holder of properties
struct Person {

  // A property called name of type string
  string Name;
  uint Age;
}

// Container for logic
contract Examples {

  // A public property called Number of type uint
  // there is no decimals in solidity so everything is whole numbers
  uint public Number; 

  // A private property called anotherNumber of type uint
  uint private anotherNumber;

  // A string
  string public Name;

  // An array of names with dynamic sizing
  string[] public Names;

  // A Person struct where we initialize a new Person named Kalle with age 5
  Person public Kalle = Person("Kalle", 5);

  // An array of Person Structs with a fixed size of 5
  Person[] public People = new Person[](5);

  // All interaction on Blockchain happens with an address. 
  // Can be a contract, token, wallet
  // In this case it's the address of the contract owner
  address public owner; 

  // Mapping is a dictionary with string as key and a uint as the value;
  mapping(string => uint) public NamesToNumbers;

  
  // The constructor taking a string as parameter.
  // Assignes some values
  constructor(string name) {
    Name = name;
    anotherName = "kalle";

    // msg is a global object that contains the address of the 
    // caller (sender). 
    owner = msg.sender;

    // using console to log out stuff.
    // block is gloabl object that contains different block information
    // in this case timestamp.
    console.log(block.timestamp);
  }

  // A public function, there is also private and internal functions
  function myFunction() public {
    Name = "name";
  }

  // A funtion that returns a value without modifing state
  function viewFunction() public view returns (string) {
    return Name;
  }

  // payable enables function to receive ether. 
  // msg.value contains the ether sent
  // the value is stored in the contract 
  function functionThatCanReceiveEther() public payable {
    uint etherSent = msg.value;
  }

  function functionWithArrayExamples() public {
    // Adding to public Names array
    Names.push("adding to array");

    // Getting from array by index
    string oneName = Names[0];

    // Looping through an array
    for (uint i = 0; i < Names.length; i++) {

      // Removing from an array
      delete Names[i];
    }
  }

  function functionWithMappingExamples() public {

    // Adding key A with value 1
    NamesToNumbers["A"] = 1;

    // Getting the value for the key
    uint value = NamesToNumbers["A"];

    // If key does not exist then value will be defaulted. Uint = 0
    uint defaultValue = NamesToNumbers["B"];

    // Delete the key-value
    delete NamesToNumbers["A"];
  }

  // modifier is like a middleware-ish. Will execute before the function code will execute.
  // Is also possible to send arguments to modifier 
  modifier onlyOwner() {

    // require will check if condition is valid, 
    // otherwise it will abort with the supplied message.
    // will revert all other changes done to state (almost like a transaction)
    require(msg.sender == owner, "only owner is allowed");

    // _; will execute the function code
    _;
  }

  // This function is only callable if you are the owner. 
  function functionOnlyForOwners() public onlyOwner {

    // Wrap an address (owner) in the payable to be able to transfer 
    // value to it. With address(this).balance we get how mush Eth 
    // the contract has and then we send all the Eth to the owner. 
    payable(owner).transfer(address(this).balance);
  }
} 