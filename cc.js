if (typeof web3 !== 'undefined')
	web3 = new Web3(web3.currentProvider);
else
	web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

var communitycurrencyContract = web3.eth.contract([ {
	"constant" : true,
	"inputs" : [],
	"name" : "getBudget",
	"outputs" : [ {
		"name" : "_getGoalDemurrage",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getGoalCrowdFunding",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getGoalCommunityHours",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getGoalExpenses",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getRealDemurrage",
		"type" : "int256",
		"value" : "0"
	}, {
		"name" : "_getRealCrowdFunding",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getRealCommunityHours",
		"type" : "int256",
		"value" : "0"
	}, {
		"name" : "_getRealExpenses",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getCommuneBalance",
		"type" : "int256",
		"value" : "0"
	}, {
		"name" : "_getTreasuryBalance",
		"type" : "int256",
		"value" : "0"
	} ],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_authorized",
		"type" : "address"
	} ],
	"name" : "accessMyWallet",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : true,
	"inputs" : [ {
		"name" : "_monitored",
		"type" : "address"
	} ],
	"name" : "monitorWallet",
	"outputs" : [ {
		"name" : "_getCCUs",
		"type" : "int256",
		"value" : "0"
	}, {
		"name" : "_getCredit",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getDeadline",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getMoneyLender",
		"type" : "address",
		"value" : "0x0000000000000000000000000000000000000000"
	}, {
		"name" : "_getUnitsOfTrust",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getIsMember",
		"type" : "bool",
		"value" : false
	}, {
		"name" : "_getReputation",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getAlias",
		"type" : "string",
		"value" : ""
	} ],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_contractor",
		"type" : "address"
	}, {
		"name" : "_payE",
		"type" : "uint256"
	} ],
	"name" : "payExpenses",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_newExchange",
		"type" : "uint256"
	} ],
	"name" : "setExchange",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_newGoalDemurrage",
		"type" : "uint256"
	}, {
		"name" : "_newGoalCrowdFunding",
		"type" : "uint256"
	}, {
		"name" : "_newGoalCommunityHours",
		"type" : "uint256"
	}, {
		"name" : "_newGoalExpenses",
		"type" : "uint256"
	} ],
	"name" : "setNewBudget",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_servant",
		"type" : "address"
	}, {
		"name" : "_payH",
		"type" : "uint256"
	} ],
	"name" : "payHours",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [],
	"name" : "creditUpdate",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_newMember",
		"type" : "address"
	}, {
		"name" : "_newAlias",
		"type" : "string"
	} ],
	"name" : "acceptMember",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_claimH",
		"type" : "int256"
	} ],
	"name" : "claimHours",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_newCommune",
		"type" : "address"
	} ],
	"name" : "newCommune",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_newTreasury",
		"type" : "address"
	} ],
	"name" : "newTreasury",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : true,
	"inputs" : [],
	"name" : "getParameters",
	"outputs" : [ {
		"name" : "_getTreasury",
		"type" : "address",
		"value" : "0x6b8a71f833549f9f381b02902d46016da456db68"
	}, {
		"name" : "_getCommunity",
		"type" : "address",
		"value" : "0x6b8a71f833549f9f381b02902d46016da456db68"
	}, {
		"name" : "_getDemurrage",
		"type" : "int256",
		"value" : "0"
	}, {
		"name" : "_getRewardRate",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getIniMemberCCUs",
		"type" : "int256",
		"value" : "0"
	}, {
		"name" : "_getIniMemberReputation",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getExchange",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "getName",
		"type" : "string",
		"value" : "HOURS"
	}, {
		"name" : "getSymbol",
		"type" : "string",
		"value" : "HR"
	}, {
		"name" : "getCommunityName",
		"type" : "string",
		"value" : "DESPERADO"
	}, {
		"name" : "getBaseUnits",
		"type" : "uint256",
		"value" : "100"
	} ],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : true,
	"inputs" : [],
	"name" : "getMoneyTotals",
	"outputs" : [ {
		"name" : "_getTotalMinted",
		"type" : "int256",
		"value" : "0"
	}, {
		"name" : "_getTotalCredit",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getTotalTrustCost",
		"type" : "uint256",
		"value" : "0"
	}, {
		"name" : "_getTotalTrustAvailable",
		"type" : "uint256",
		"value" : "0"
	} ],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_payee",
		"type" : "address"
	}, {
		"name" : "_payment",
		"type" : "uint256"
	} ],
	"name" : "transfer",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_newDemurrage",
		"type" : "int256"
	}, {
		"name" : "_newRewardRate",
		"type" : "uint256"
	}, {
		"name" : "_newIniCCUs",
		"type" : "int256"
	}, {
		"name" : "_newIniR",
		"type" : "uint256"
	} ],
	"name" : "newParameters",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_oldMember",
		"type" : "address"
	} ],
	"name" : "kickOutMember",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_borrower",
		"type" : "address"
	}, {
		"name" : "_credit",
		"type" : "uint256"
	}, {
		"name" : "_daysAfter",
		"type" : "uint256"
	} ],
	"name" : "credit",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"constant" : false,
	"inputs" : [ {
		"name" : "_payF",
		"type" : "uint256"
	} ],
	"name" : "payFunding",
	"outputs" : [],
	"payable" : false,
	"type" : "function"
}, {
	"inputs" : [],
	"payable" : false,
	"type" : "constructor"
}, {
	"anonymous" : false,
	"inputs" : [ {
		"indexed" : false,
		"name" : "_amount",
		"type" : "uint256"
	}, {
		"indexed" : true,
		"name" : "_from",
		"type" : "address"
	}, {
		"indexed" : true,
		"name" : "_to",
		"type" : "address"
	}, {
		"indexed" : false,
		"name" : "_timeStampT",
		"type" : "uint256"
	} ],
	"name" : "Transfer",
	"type" : "event"
}, {
	"anonymous" : false,
	"inputs" : [ {
		"indexed" : true,
		"name" : "_member",
		"type" : "address"
	}, {
		"indexed" : false,
		"name" : "_alias",
		"type" : "string"
	} ],
	"name" : "NewMember",
	"type" : "event"
}, {
	"anonymous" : false,
	"inputs" : [ {
		"indexed" : true,
		"name" : "_exMember",
		"type" : "address"
	}, {
		"indexed" : false,
		"name" : "_exAlias",
		"type" : "string"
	} ],
	"name" : "OldMember",
	"type" : "event"
}, {
	"anonymous" : false,
	"inputs" : [ {
		"indexed" : true,
		"name" : "_MoneyLender",
		"type" : "address"
	}, {
		"indexed" : true,
		"name" : "_borrowerAddress",
		"type" : "address"
	}, {
		"indexed" : false,
		"name" : "_cDealine",
		"type" : "uint256"
	}, {
		"indexed" : false,
		"name" : "_endorsedUoT",
		"type" : "uint256"
	} ],
	"name" : "Credit",
	"type" : "event"
}, {
	"anonymous" : false,
	"inputs" : [ {
		"indexed" : true,
		"name" : "_MoneyLender",
		"type" : "address"
	}, {
		"indexed" : true,
		"name" : "_exBorrowerAddress",
		"type" : "address"
	}, {
		"indexed" : false,
		"name" : "_oldUoT",
		"type" : "uint256"
	}, {
		"indexed" : false,
		"name" : "_success",
		"type" : "bool"
	}, {
		"indexed" : false,
		"name" : "_timeStampCX",
		"type" : "uint256"
	} ],
	"name" : "CreditExp",
	"type" : "event"
}, {
	"anonymous" : false,
	"inputs" : [ {
		"indexed" : true,
		"name" : "_hFrom",
		"type" : "address"
	}, {
		"indexed" : false,
		"name" : "_servantC",
		"type" : "string"
	}, {
		"indexed" : false,
		"name" : "_claimedH",
		"type" : "int256"
	}, {
		"indexed" : false,
		"name" : "_timeStampCH",
		"type" : "uint256"
	} ],
	"name" : "ClaimH",
	"type" : "event"
}, {
	"anonymous" : false,
	"inputs" : [ {
		"indexed" : true,
		"name" : "_hTo",
		"type" : "address"
	}, {
		"indexed" : false,
		"name" : "_servantP",
		"type" : "string"
	}, {
		"indexed" : false,
		"name" : "_paidH",
		"type" : "uint256"
	}, {
		"indexed" : false,
		"name" : "_timeStampPH",
		"type" : "uint256"
	} ],
	"name" : "PaidH",
	"type" : "event"
} ]);

var communityCurrency = communitycurrencyContract
		.at("0xf17a1959fBd8aaA1D4aaac9fCf32a77e70E8ad75");

var accounts = web3.eth.accounts;
var nrAcc = accounts.length;

web3.eth.defaultAccount = accounts[0];
var coinbase = web3.eth.defaultAccount;

var myWallet = communityCurrency.monitorWallet(coinbase);
var myCommunityCUnits = myWallet[0];
var myCredit = myWallet[1];
var myDeadline = myWallet[2];
var myMoneyLender = myWallet[3];
var myUnitsOfTrust = myWallet[4];
var myIsMember = myWallet[5];
var myReputation = myWallet[6];
var myAlias = myWallet[7];
var available = Number(myCredit) + Number(myCommunityCUnits);

var contractParameters = communityCurrency.getParameters();
var treasury = contractParameters[0];
var commune = contractParameters[1];
var demurrage = contractParameters[2];
var rewardRate = contractParameters[3];
var iniMemberCCUs = contractParameters[4];
var iniMemberReputation = contractParameters[5];
var exchangeRate = contractParameters[6];
var name = contractParameters[7];
var symbol = contractParameters[8];
var communityName = contractParameters[9];
var baseUnits = contractParameters[10];

if (myIsMember == true) {
	var commoner = "Commoner of " + communityName + " Community";
} else {
	commoner = "Not Commoner";
	myAlias = "visitor";
};

var dateMyDealine = new Date(myDeadline * 1000);
