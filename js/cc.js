var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider());
var from = web3.eth.coinbase;
web3.eth.defaultAccount = from;

var communitycurrencyContract = web3.eth.contract([
{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"type":"function"},
{"constant":false,"inputs":[{"name":"_authorized","type":"address"}],"name":"accessMyWallet","outputs":[],"type":"function"},
{"constant":true,"inputs":[{"name":"_monitored","type":"address"}],"name":"monitorWallet","outputs":[{"name":"_getCCUs","type":"int256"},
{"name":"_getCredit","type":"uint256"},{"name":"_getDeadline","type":"uint256"},{"name":"_getMoneyLender","type":"address"},
{"name":"_getUnitsOfTrust","type":"uint256"},{"name":"_getIsMember","type":"bool"},{"name":"_getAlias","type":"string"},
{"name":"_getReputation","type":"uint256"},{"name":"_getLast","type":"uint256"},{"name":"_getGdpActivity","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"_beneficiary","type":"address"},
{"name":"_createReputation","type":"uint256"}],"name":"mintAssignReputation","outputs":[],"type":"function"},
{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"type":"function"},
{"constant":false,"inputs":[{"name":"_createCCUs","type":"int256"}],"name":"mintCCUs","outputs":[],"type":"function"},
{"constant":false,"inputs":[{"name":"_newCommunity","type":"address"}],"name":"newCommunity","outputs":[],"type":"function"},
{"constant":false,"inputs":[{"name":"_newMember","type":"address"},
{"name":"_newAlias","type":"string"}],"name":"acceptMember","outputs":[],"type":"function"},
{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"type":"function"},
{"constant":false,"inputs":[{"name":"_newTreasury","type":"address"}],"name":"newTreasury","outputs":[],"type":"function"},
{"constant":false,"inputs":[{"name":"_payee","type":"address"},{"name":"_payment","type":"uint256"}],"name":"transfer","outputs":[],"type":"function"},
{"constant":false,"inputs":[{"name":"_newDemurrage","type":"int256"},{"name":"_newrewardRate","type":"uint256"},
{"name":"_newIniCCUs","type":"int256"},{"name":"_newIniR","type":"uint256"}],"name":"newParameters","outputs":[],"type":"function"},
{"constant":false,"inputs":[{"name":"_oldMember","type":"address"}],"name":"kickOutMember","outputs":[],"type":"function"},
{"constant":false,"inputs":[{"name":"_borrower","type":"address"},
{"name":"_credit","type":"uint256"},{"name":"_daysAfter","type":"uint256"}],"name":"credit","outputs":[],"type":"function"},
{"inputs":[],"type":"constructor"},
{"anonymous":false,"inputs":[{"indexed":false,"name":"_payment","type":"uint256"},
{"indexed":false,"name":"_myBalanceCCUs","type":"int256"},{"indexed":true,"name":"_to","type":"address"}],"name":"Transfer","type":"event"},
{"anonymous":false,"inputs":[{"indexed":false,"name":"_credit","type":"uint256"},{"indexed":false,"name":"_blocks","type":"uint256"},
{"indexed":false,"name":"_myunitsOfTrust","type":"uint256"},{"indexed":false,"name":"_myReputationBalance","type":"uint256"},
{"indexed":true,"name":"_borrower","type":"address"}],"name":"Credit","type":"event"}
]);

var communitycurrency = communitycurrencyContract.new()

var communityCurrency = communitycurrencyContract.at(address);

function createTransaction() {
	var receiverAddress = '0x' + document.querySelector('#receiverAddress').value;
	var amount = document.querySelector('#amount').value;
	var data = [receiverAddress, amount];
	web3.eth.transact({to: contractAddress, data: data, gas: 5000});
}

web3.eth.watch({altered: {at: web3.eth.accounts[0], id: contractAddress}}).changed(function() {
	document.getElementById('account').innerText = web3.eth.stateAt(contractAddress, web3.eth.accounts[0]);
	document.getElementById('communityCUnits').innerText = web3.toDecimal(web3.eth.stateAt(contractAddress, web3.eth.accounts[0]));
});

function acceptMember () {}

function kickOutMember () {}

function newParameters () {}

function newCommunity () {}

function newTreasury () {}

function mintAssignCCUs () {}

function mintAssignReputation () {}

function transfer() {}

function credit()  {}

function monitorWallet() {}

function accessMyWallet () {}
