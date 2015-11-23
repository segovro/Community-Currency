//http://desperado-theory.blogspot.be/2015/05/what-hell-is-p2p-_credit.html
//http://desperado-theory.blogspot.com.es/2015/08/moneda-con-pagos-y-_creditos-p2p-sin.html
contract communityCurrency {
	
	//communityCurrency currency general variables
	address _treasury; //the address of the treasury of the DAO. The creator and minter of the currency
	address _community; //the address of the Community account. Where donations and taxes are paid. Account used to pay community works. 
	int _vatRate; //the depreciation at each transaction. The VAT to be paid to the DAO at the community account. % x 100
	uint _rewardRate; //reward Rate to the moneyLender of a successful credit, as a multiplier of the creditLine _amountCCUs. % x 100
	
	//communityCurrency currency parameters of a given Community	
	function communityCurrency () {
		_treasury = msg.sender;  
		_community = 0x06400992be45bc64a52b5c55d3df84596d6cb4a1; 
		_vatRate = 3;
		_rewardRate = 20;
	}
	
	//members wallet
	struct communityCurrencyWallet {
		int _communityCUnits; //balanceCCs is the actual balance of the currency CCs in the Wallet of the account. It can be negative!!!	
		uint _credit; //credit is the limit of balanceCCs the account is authorized to become negative	
		uint _deadline; //deadline is the time limit on which the credit should be already cancelled and becomes zero again. Its measured in number of _blocks
		address _moneyLender; //moneyLender is the address of the money lender. The credit line authorizer.
		uint _reputation; //Reputation is the volume of the _credit in terms of balance Reputation Cost the money lender can authorize; that is, his available balance Reputation Cost 
		uint _reputationCost; //reputationCost is the cost in balanceReputation of a particular credit line authorization. It is calculated in terms of credit volume time x amountCCs
		bool _isMember; //if an address corresponds to an accepted member
	}
	
	mapping (address => communityCurrencyWallet) balancesOf;	
	
	event Transfer(uint _payment, int _myBalanceCCUs, address indexed _to);
	event Credit(uint _credit, uint _blocks, uint _myReputationCost, uint _myReputationBalance, address indexed _borrower);

//the community can accept accounts as members
	//a community can opt to name itself member or not and therefore give credits or not
	function acceptMember (address _newMember) {
        if (msg.sender != _community) return;
        balancesOf[_newMember]._isMember = true;
       }
	//the community can kick out members
	function kickOutMember (address _oldMember) {
        if (msg.sender != _community) return;
        balancesOf[_oldMember]._isMember = false;
       }
	
	
//the treasury can issue as much communityCurrency it likes and send it to any Member; 
	//mint communityCurrency
	//warning: it increases the monetary mass. The only way to decrease it is to store it again at the treasury
	function mintAssignCCUs (address _beneficiary, int _createCCUs) {
        if (msg.sender != _treasury) return;
		if (balancesOf[_beneficiary]._isMember != true) return;
		balancesOf[_beneficiary]._communityCUnits += _createCCUs;
	}

//the community can issue as much Reputation it likes and send it to any Member; 
	//mint Reputation
	function mintAssignReputation (address _beneficiary, uint _createReputation) {
        if (msg.sender != _community) return;
		if (balancesOf[_beneficiary]._isMember != true) return;
        balancesOf[_beneficiary]._reputation += _createReputation;
       }
	
//function make a payment
	//anybody can make a payment if he has sufficient CCUs and or credit
	function transfer(address _payee, uint _payment) {
	//update the credit status
		if (balancesOf[msg.sender]._credit > 0) {
		//check if deadline is over
			if (block.number > balancesOf[msg.sender]._deadline) {
			//if time is over reset credit to zero, deadline to zero					
				balancesOf[msg.sender]._deadline = 0;
				balancesOf[msg.sender]._credit = 0;
				//if balance is negative the credit was not returned, the money lender balanceReputation is not restored and is penalized with a 20%
				if (balancesOf[msg.sender]._communityCUnits < 0) {
					balancesOf[balancesOf[msg.sender]._moneyLender]._reputation -= balancesOf[msg.sender]._reputationCost * _rewardRate/100;
				}
					//if balance is not negative the credit was returned, the money lender balanceReputation is restored and is rewardRateed with a 20%
				else {
					balancesOf[balancesOf[msg.sender]._moneyLender]._reputation += balancesOf[msg.sender]._reputationCost * (100 + _rewardRate)/100;
				}	
		//if time is not over proceed with the payment
			}
	//if there was no credit proceed
		}
	//pay with the reviewed balance and credit
		int _creditLine = int(balancesOf[msg.sender]._credit);
		int _available = balancesOf[msg.sender]._communityCUnits + _creditLine; //is the spending limit of an account, given the account balance in _communityCUnits and the _credit
		int _amountCCUs = int(_payment); 
		if (_available > _amountCCUs) {
		balancesOf[msg.sender]._communityCUnits -= _amountCCUs;
		balancesOf[_payee]._communityCUnits += _amountCCUs;
		//apply vatRate
		balancesOf[_payee]._communityCUnits -= _amountCCUs * _vatRate/100;
		balancesOf[_community]._communityCUnits += _amountCCUs * _vatRate/100;
		Transfer(_payment, balancesOf[msg.sender]._communityCUnits, _payee);
		}
	}
	

	//function authorize a credit
	//only members can authorize or get a credit
	function credit(address _borrower, uint _credit, uint _blocks)  {
		if (balancesOf[msg.sender]._isMember != true) return;
		if (balancesOf[_borrower]._isMember != true) return;
		if (balancesOf[msg.sender]._reputation > _credit * _blocks) {
				balancesOf[msg.sender]._reputation -= _credit * _blocks;
				balancesOf[_borrower]._credit += _credit;
				balancesOf[_borrower]._moneyLender = msg.sender;
				balancesOf[_borrower]._deadline = block.number + _blocks; //the _deadline is established as a number of _blocks ahead
				balancesOf[_borrower]._reputationCost = _credit * _blocks;
				Credit(_credit, _blocks, balancesOf[_borrower]._reputationCost, balancesOf[msg.sender]._reputation, _borrower);
			}
		}

	//myWallet
    function myWallet() constant returns (int _myCCUs, uint _myReputation, uint _myCredit, uint _myDeadline, bool _amIMember) {
        _myCCUs = balancesOf[msg.sender]._communityCUnits;
		_myReputation = balancesOf[msg.sender]._reputation;
		_myCredit = balancesOf[msg.sender]._credit;
		_myDeadline = balancesOf[msg.sender]._deadline;
		_amIMember = balancesOf[msg.sender]._isMember;
    }
}
