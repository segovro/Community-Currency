contract communityCurrency {
	
	// @title Community Currency
	// @author Rogelio SEGOVIA	
	// @notice register 
	// @param name the name of the currency
	// @param symbol the symbol of the currency
	// @param baseUnits is the number of units before the comma 
    uint baseUnits;
    string name;
    string symbol; 
    string communityName;

    // @notice communityCurrency general variables
    // @param _treasury the address of the treasury of the DAO. The creator and minter of the currency
    // @param _commune the address of the Community account. Where donations and taxes are paid. Account used to pay community works
    // @param _demurrage the depreciation at each transaction. The demurrage to be paid to the DAO at the community account. % x 100
    // @param _rewardRate reward Rate to the moneyLender of a successful credit, as a multiplier of the Reputation Cost of the credit. % x 100
    // @param _iniMemberCCUs initial Community Currency Units given to any new member. The monetary mass is automatically increased with any new member
    // @param _iniMemberReputation initial Reputation given to any new member
	// @param _exchange is the exchange rate in EUROS per Community Currency units
    address _treasury; 
	address _commune;  
	int _demurrage; 
	uint _rewardRate; 
	int _iniMemberCCUs; 
	uint _iniMemberReputation;
	uint _exchange;
	
	// @notice Budget parameters
	uint _goalDemurrage;
	uint _goalCrowdFunding;
	uint _goalCommunityHours;
	uint _goalExpenses;
	uint _commitCrowdFunding;
	int _commitCommunityHours;
	uint _commitExpenses;
	int _realDemurrage;
	uint _realCrowdFunding;
	int _realCommunityHours;
	uint _realExpenses;
	
	//@notice monetary Totals
	int _totalMinted;
	uint _totalCredit;
	uint _totalTrustCost;
	uint _totalTrustAvailable;

	// @notice communityCurrency parameters and key addresses for a given Community	
	function communityCurrency () {
		_treasury = msg.sender;  
		_commune = msg.sender; 
		_demurrage = 3;
		_rewardRate = 20;
		_iniMemberCCUs = 2500;
		_iniMemberReputation = 12500;
		_exchange = 10;
		baseUnits = 100;
		name = "HOUR";
		symbol = "HR";
		communityName = "DESPERADO"; 		
		_goalDemurrage = 0;
		_goalCrowdFunding = 0;
		_goalCommunityHours = 0;
		_goalExpenses = 0;
		_commitCrowdFunding = 0;
		_commitCommunityHours = 0;
		_commitExpenses = 0;
		_realDemurrage = 0;
		_realCrowdFunding = 0;
		_realCommunityHours = 0;
		_realExpenses = 0;
		_totalMinted = 0;
		_totalCredit = 0;
		_totalTrustCost = 0;
		_totalTrustAvailable = 0;
	}
	
	
	// @notice structure the members wallet
	// @param _CCUs is the actual balance of the currency CCs in the Wallet of the account. It can be negative!!!	
	// @param _credit is the limit of _CCUs the account is authorized to become negative
	// @param _deadline is the time limit on which the credit should be already cancelled and becomes zero again
	// @param _moneyLender is the address of the money lender. The credit line authorizer
	// @param _unitsOfTrust is the cost in reputation (Units of Trust) of credit line the account has been authorized. The Trust endorsed to this account by the money lender. It is calculated in terms of credit volume = time x amountCCs
	// @param _isMember boolean if it is an accepted member
	// @param _alias is a string with the alias or ID of the member
	// @param _reputation is the volume of the credit in terms of balance of Units of Trust the money lender can authorize; that is, his available balance in Units of Trust he may endorse to others 
	// @param _last time stamp of the last transaction
	// @param _gdpActivity measures the average economic activity of the account in a time period. It measures the monetary mass moved by an account as m x v
	struct Wallet {
		int _CCUs; 
		uint _credit; 
		uint _deadline; 
		address _moneyLender; 
		uint _unitsOfTrust; 
		bool _isMember; 
		uint _reputation; 
		uint _last; 
		uint _gdpActivity; 
		int _commitH;
		uint _commitF;
		bytes32 _alias; 
		bytes32 _email;
	}
	address[] commoners;
	
	mapping (address => Wallet) balancesOf;	
	
	event Transfer(uint _amount, address indexed _from, address indexed _to, uint _timeStampT);
	event Credit(uint _cDealine, uint _endorsedUoT, bytes32 _moneyLender);
    event CreditExp(uint _oldUoT , bytes32 _oldMoneyLender, bool _success, uint _timeStampCX);
	event ClaimH (bytes32 _servantC, address indexed _hFrom, int _claimedH, uint _timeStampCH);
	event PaidH (bytes32 _servantP, uint _paidH, uint _timeStampPH);
	
	// @notice the community account can accept accounts as members. The Community should ensure the unique correspondence to a real person 
	// @notice a community can opt to name itself member or not and therefore give credits or not
	// @param _newMember is the address of the new member
	// @param _newAlias is the alias or human readable ID of the new member
	// @return changed alias, initial balance in CCUs, initial reputation in UoT
	function acceptMember (address _newMember, bytes32 _newAlias, bytes32 _newEmail) {
        if (msg.sender != _commune) return;
        if ((_newEmail =="")||(_newAlias =="")) throw;
        balancesOf[_newMember]._isMember = true;
		balancesOf[_newMember]._CCUs = _iniMemberCCUs;
        balancesOf[_newMember]._reputation = _iniMemberReputation;
        balancesOf[_newMember]._last = now;
        balancesOf[_newMember]._gdpActivity = 0;
        balancesOf[_newMember]._commitH = 0;
        balancesOf[_newMember]._commitF = 0;
		balancesOf[_newMember]._alias = _newAlias;
		balancesOf[_newMember]._email = _newEmail;
		commoners.push(_newMember);
		_totalMinted += _iniMemberCCUs;
		_totalTrustAvailable += _iniMemberReputation;    
    }
	
	// @notice auxiliary internal function to retrieve an index in the addresses array form its address
	function findCommonersIndex(address _addr) returns (uint _index){
	    for (uint i = 0; i < commoners.length; i++){
	        if (commoners[i] == _addr) {
	        	_index = i;
	        } 
	    }
	}
	
	// @notice returns the count of current active users
	function getNumberCommoners() returns (uint _numberCommoners){
		_numberCommoners = commoners.length;
	}
	
	// @notice the community account can kick out members. The action deletes all balances
	// @param _oldMember is the address of the member to be kicked out
	// @return isMember turned to false, all other account balances to zero, except _CCUs
	function kickOutMember (address _oldMember) {
        if (msg.sender != _commune) return;        
        balancesOf[_oldMember]._isMember = false;
		_totalCredit = balancesOf[_oldMember]._credit;
		balancesOf[balancesOf[_oldMember]._moneyLender]._reputation += balancesOf[_oldMember]._unitsOfTrust;
		_totalTrustAvailable -= balancesOf[_oldMember]._reputation;
		_totalTrustAvailable += balancesOf[_oldMember]._unitsOfTrust;
		_commitCrowdFunding -= balancesOf[_oldMember]._commitF;
		_commitCommunityHours -= balancesOf[_oldMember]._commitH;
        balancesOf[_oldMember]._reputation = 0;
        balancesOf[_oldMember]._credit = 0;
        balancesOf[_oldMember]._deadline = 0;
        balancesOf[_oldMember]._last = now;
        balancesOf[_oldMember]._gdpActivity = 0;
        balancesOf[_oldMember]._commitH = 0;
        balancesOf[_oldMember]._commitF = 0;
        uint _index = findCommonersIndex(_oldMember);
		if (_index > 0){
	        delete commoners[_index];
	        commoners.length--;
		}
    }
	
	// @notice get the currency parameters
	function getParameters() constant returns (address _getTreasury, address _getCommunity, int _getDemurrage, uint _getRewardRate, int _getIniMemberCCUs, uint _getIniMemberReputation, uint _getExchange, string getName, string getSymbol, string getCommunityName, uint getBaseUnits) {
		_getTreasury = _treasury;
		_getCommunity = _commune;
		_getDemurrage = _demurrage;
		_getRewardRate = _rewardRate;
		_getIniMemberCCUs = _iniMemberCCUs;
		_getIniMemberReputation = _iniMemberReputation;
		_getExchange = _exchange;
		getName = name;
		getSymbol = symbol;
		getCommunityName = communityName;
		getBaseUnits = baseUnits;
	}
	
	// @ notice get the monetary Totals
	function getMoneyTotals() constant returns (int _getTotalMinted, uint _getTotalCredit, uint _getTotalTrustCost, uint _getTotalTrustAvailable) {
		_getTotalMinted = _totalMinted;
		_getTotalCredit = _totalCredit;
		_getTotalTrustCost = _totalTrustCost;
		_getTotalTrustAvailable = _totalTrustAvailable;
	}

	// @notice the treasury account can change the currency parameters
	// @param _newDemurrage is the new demurrage rate. % x 100
	// @param _newrewardRate is the new reward rate for successful credits. % x 100
	// @param _newIniCCUs is the new initial Community Currency Units given to any new member
	// @param _newIniR is the new initial Reputation given to any new member
	// @return new demurrage, reward rate, initial CCUs and initial reputation for new members
	function newParameters (int _newDemurrage, uint _newRewardRate, int _newIniCCUs, uint _newIniR) {
		if (msg.sender != _treasury) return;
		_demurrage = _newDemurrage;
		_rewardRate = _newRewardRate;
		_iniMemberCCUs = _newIniCCUs;
		_iniMemberReputation = _newIniR;
	}
	
	// @notice the treasury account can change to a new community address
	// @param _newCommunity is the new address holding the Community permissions
	// @return new community address
	function newCommune (address _newCommune) {
		if (msg.sender != _treasury) return;
		_commune = _newCommune;
	}
	
	// @notice the community account can change to a new treasury address
	// @param _newTreasury is the new address holding the Community permissions
	// @return new treasury address
	function newTreasury (address _newTreasury) {
		if (msg.sender != _commune) return;
		_treasury = _newTreasury;
	}
	
	// @notice the treasury account can issue as much communityCurrency it likes and send it to the Community account 
	// @notice it mints new communityCurrency and thus increases the monetary mass
	// @notice it can be negative, taking money from the Community account and destroying it, thus diminishing the total monetary mass
	// @param _createCCUs is the amount of CCUs to be created or destroyed
	// @return more (or less) money in the community account
	function mintCCUs (int _createCCUs) {
        if (msg.sender != _treasury) return;
		balancesOf[_commune]._CCUs += _createCCUs;
		_totalMinted += _createCCUs;
	}

	// @notice the community account can issue as much Reputation it likes and send it to any Member; it can mint Reputation
	// @param _beneficiary is the address of the beneficiary
	// @param _createReputation is the amount of reputation to be allocated; it is always positive
	// @return more reputation in somebody account
	function mintAssignReputation (address _beneficiary, uint _createReputation) {
        if (msg.sender != _commune) return;
		if (balancesOf[_beneficiary]._isMember != true) return;
        balancesOf[_beneficiary]._reputation += _createReputation;
    }

	// @notice get Commune budget state
	function getBudget() constant returns (uint _getGoalDemurrage, uint _getGoalCrowdFunding, uint _getGoalCommunityHours, uint _getGoalExpenses, uint _getcommitCrowdFunding, int _getCommitCommunityHours, uint _getCommitExpenses, int _getRealDemurrage, uint _getRealCrowdFunding, int _getRealCommunityHours, uint _getRealExpenses, int _getCommuneBalance, int _getTreasuryBalance) {
			_getGoalDemurrage = _goalDemurrage;
			_getGoalCrowdFunding = _goalCrowdFunding;
			_getGoalCommunityHours = _goalCommunityHours;
			_getGoalExpenses = _goalExpenses;
			_getcommitCrowdFunding = _commitCrowdFunding;
			_getCommitCommunityHours = _commitCommunityHours;
			_getCommitExpenses = _commitExpenses;
			_getRealDemurrage = _realDemurrage;
			_getRealCrowdFunding = _realCrowdFunding;
			_getRealCommunityHours = _realCommunityHours;
			_getRealExpenses = _realExpenses;
			_getCommuneBalance = balancesOf[_commune]._CCUs;
			_getTreasuryBalance = balancesOf[_treasury]._CCUs;
		}

	// @notice set new rolling Commune budget
	function setNewBudget (uint _newGoalDemurrage, uint _newGoalCrowdFunding, uint _newGoalCommunityHours, uint _newGoalExpenses) {
			_goalDemurrage = _newGoalDemurrage;
			_goalCrowdFunding = _newGoalCrowdFunding;
			_goalCommunityHours = _newGoalCommunityHours;
			_goalExpenses = _newGoalExpenses;
			_realDemurrage = 0;
			_realCrowdFunding = 0;
			_realCommunityHours = 0;
			_realExpenses = 0;		
		}
	
	function setExchange (uint _newExchange) {
		if (msg.sender != _treasury) return;
		_exchange = _newExchange;
	}

	function creditUpdate () {
		// @notice update the credit status
		if (balancesOf[msg.sender]._isMember == true) {
		if (balancesOf[msg.sender]._credit > 0) {
		// @notice check if deadline is over
			if (now >= balancesOf[msg.sender]._deadline) {
				bool _success = false;
				uint _oldCredit = balancesOf[msg.sender]._credit;
				uint _oldUoT = balancesOf[msg.sender]._unitsOfTrust;
				bytes32 _oldMoneyLender = balancesOf[balancesOf[msg.sender]._moneyLender]._alias;
			// @notice if time is over reset credit to zero, deadline to zero
				balancesOf[msg.sender]._deadline = 0;
				_totalCredit -= balancesOf[msg.sender]._credit;
				balancesOf[msg.sender]._credit = 0;
				// @notice if balance is negative the credit was not returned, the money lender balanceReputation is not restored and is penalized with a 20%
				// @notice as regards the borrower will not be able to make any new transfer until future incomes cover the debts
				// @return money lender reputation penalized
				if (balancesOf[msg.sender]._CCUs < 0) {
					_totalTrustCost -= balancesOf[msg.sender]._unitsOfTrust;
					_totalTrustAvailable -= balancesOf[msg.sender]._unitsOfTrust * _rewardRate/100;
					balancesOf[balancesOf[msg.sender]._moneyLender]._reputation -= balancesOf[msg.sender]._unitsOfTrust * _rewardRate/100;
				}
				// @notice if balance is not negative the credit was returned, the money lender balanceReputation is restored and is rewardRateed with a 20%
				// @return money lender reputation rewarded
				else {
					_success = true;
					_totalTrustCost -= balancesOf[msg.sender]._unitsOfTrust;
					_totalTrustAvailable += balancesOf[msg.sender]._unitsOfTrust * _rewardRate/100;
					balancesOf[balancesOf[msg.sender]._moneyLender]._reputation += balancesOf[msg.sender]._unitsOfTrust * (100 + _rewardRate)/100;
				}
				// @notice reset money lender information
				// @return money lender information deleted
				// @notice close access to monitor the account to money lender
				balancesOf[msg.sender]._moneyLender = msg.sender; 
				balancesOf[msg.sender]._unitsOfTrust = 0;
				CreditExp(_oldUoT , _oldMoneyLender, _success, now);
				} 
			}
		}
	}
			

	// @notice function make a payment
	// @notice anybody with an ethereum account can make a payment if he has sufficient CCUs in the balance
	// @notice any member can add to the amount available at the balance, what remains unused in the credit line
	// @param _payee is the account to be credited
	// @param _payment is the amount in CCUs to be send
	// @return balance of payee increased
	// @return balance of sender decreased
	// @return in case of need, available credit decreased	
	function transfer (address _payee, uint _payment) {
	// @return credit information updated
		creditUpdate ();
	// @notice pay with the CCUs available at the balance and the credit
		int _creditLine = int(balancesOf[msg.sender]._credit);
		// @param _available is the spending limit of an account, given the account balance in _CCUs and the _credit
		int _available = balancesOf[msg.sender]._CCUs + _creditLine; 
		int _amountCCUs = int(_payment); 
		if (_available > _amountCCUs) {
			balancesOf[msg.sender]._CCUs -= _amountCCUs;
			balancesOf[_payee]._CCUs += _amountCCUs;
			// @notice apply demurrage and send it to the Community account
			balancesOf[_payee]._CCUs -= _amountCCUs * _demurrage/100;
			balancesOf[_commune]._CCUs += _amountCCUs * _demurrage/100;
			_realDemurrage += _amountCCUs * _demurrage/100;
			Transfer(_payment, msg.sender, _payee, now);
	// @notice update the Activity indicator
			balancesOf[msg.sender]._gdpActivity = (1 days * _payment)/(now - balancesOf[msg.sender]._last);
			balancesOf[msg.sender]._last = now;
		}
	}

	// @notice function authorize a credit
	// @notice only members can authorize or get a credit
	// @param _borrower is the address of the credit borrower
	// @param _credit is the amount of the credit line in CCUs
	// @param _daysAfter is the deadline of the credit line in number of days from today
	function credit(address _borrower, uint _credit, uint _daysAfter)  {
		if (balancesOf[msg.sender]._isMember == true) {
		if (balancesOf[_borrower]._isMember == true) {
		if (balancesOf[_borrower]._credit > 0) return;
			uint _unitsOfTrust = _credit * _daysAfter;
			if (balancesOf[msg.sender]._reputation > _unitsOfTrust) {
				balancesOf[msg.sender]._reputation -= _unitsOfTrust;
				balancesOf[_borrower]._credit += _credit;
				balancesOf[_borrower]._moneyLender = msg.sender;
				// @notice the _deadline is established as a number of days ahead
				uint _creditDeadline = now + _daysAfter * 1 days; 
				bytes32 _moneyLenderAlias = balancesOf[msg.sender]._alias;
				balancesOf[_borrower]._deadline = _creditDeadline; 
				balancesOf[_borrower]._unitsOfTrust = _unitsOfTrust;
				_totalCredit += _credit;
				_totalTrustCost += _unitsOfTrust;
				_totalTrustAvailable -= _unitsOfTrust;
				Credit(_creditDeadline, _unitsOfTrust, _moneyLenderAlias);		
			}
		}}
	}
	
  	// @notice monitor Wallet
  	// @notice the borrower candidate has given access to monitor all relevant parameters of his account to the money lender
	// @notice the community can also monitor all accounts
	// @dev if you want to disallow the community to monitor all accounts delete the OR | (msg.sender == _commune) |
	// @param _monitored is the address to be monitored
	// @return _getCCUs is the balance in CCUs 
	// @return _getCredit is the remaining credit
	// @return _getDeadline is the credit deadline
	// @return _getMoneyLender is the address of the current money lender or the candidate money lender
	// @return _getUnitsOfTrust is the cost in reputation of the credit
	// @return _getIsMember is boolean if the account is a member
	// @return _getAlias is the alias
	// @return _getReputation is the reputation in UoTs
	// @return _getLast is the date of the last transaction
	// @return _getGdpActivity is the average activity
	function monitorWallet(address _monitored) constant returns (int _getCCUs, uint _getCredit, uint _getDeadline, address _getMoneyLender, uint _getUnitsOfTrust, bool _getIsMember, uint _getReputation, uint _getLast, uint _getGdpActivity, int _getCommitH, uint _getCommitF, bytes32 _getAlias, bytes32 _getEmail) {
		if ((_monitored == msg.sender) || (msg.sender == _commune) || (msg.sender == balancesOf[_monitored]._moneyLender)) {
    	_getCCUs = balancesOf[_monitored]._CCUs;	
		_getCredit = balancesOf[_monitored]._credit;
		_getDeadline = balancesOf[_monitored]._deadline;
		_getMoneyLender = balancesOf[_monitored]._moneyLender;
		_getUnitsOfTrust = balancesOf[_monitored]._unitsOfTrust;
		_getIsMember = balancesOf[_monitored]._isMember;		
		_getReputation = balancesOf[_monitored]._reputation;
		_getLast = balancesOf[_monitored]._last;
		_getGdpActivity = balancesOf[_monitored]._gdpActivity;
		_getCommitH = balancesOf[_monitored]._commitH;
		_getCommitF = balancesOf[_monitored]._commitF;
		_getAlias = balancesOf[_monitored]._alias;
		_getEmail = balancesOf[_monitored]._email;
		}
    	}
  	
  	// @notice list a Commoner
	function listCommoner(uint _index) constant returns (address _getAddress, bytes32 _getAlias, bytes32 _getEmail) {
  		address _cAddress = commoners[_index];
    	_getAddress = _cAddress;	
		_getAlias = balancesOf[_cAddress]._alias;
		_getEmail = balancesOf[_cAddress]._email;
    	}  	  	
	
   // @notice authorize monitoring
   function accessMyWallet (address _authorized) {
	   // @notice during a credit, only the money lender and the community have access
	   // @notice normally, the authorization to monitor own accounts is given to a candidate money lender
	   if (balancesOf[msg.sender]._credit != 0) return;
	   balancesOf[msg.sender]._moneyLender = _authorized;
   }
	
	// @notice committ Hours
	function commitHours (int _commitH) {
		balancesOf[msg.sender]._commitH += _commitH;
		_commitCommunityHours += _commitH;
	}
	
	// @notice claim Hours to paid from Community
	function claimHours (int _claimH) {
		if (balancesOf[msg.sender]._commitH > _claimH) {
		bytes32 myAlias = balancesOf[msg.sender]._alias;
		ClaimH (myAlias, msg.sender, _claimH, now);
		}
	}
	
	// @notice pay Hours
	function payHours (address _servant, uint _payH) {
	if (msg.sender != _commune) return;
	transfer (_servant, _payH);
		balancesOf[_servant]._commitH -= int(_payH);
		_commitCommunityHours -= int(_payH);
		_realCommunityHours += int(_payH);
		bytes32 _servantAlias = balancesOf[_servant]._alias;
		PaidH (_servantAlias, _payH, now);
	}
	
	// @notice committ Funding
	function commitFunding (uint _commitF) {
		balancesOf[msg.sender]._commitF += _commitF;
		_commitCrowdFunding += _commitF;
	}
	
	// @notice pay Funding
	function payFunding (uint _payF) {
	transfer (_commune, _payF);
		balancesOf[msg.sender]._commitF -= _payF;
		_commitCrowdFunding -= _payF;
		_realCrowdFunding += _payF;
	}
	
	// @notice committ Expenses
	function commitExpenses (uint _commitE) {
	if (msg.sender != _commune) return;
		_commitExpenses += _commitE;
	}
	
	// @notice pay Expenses
	function payExpenses (address _contractor, uint _payE) {
	if (msg.sender != _commune) return;
	if (_payE > _commitExpenses) return;
	transfer (_contractor, _payE);
		_commitExpenses -= _payE;
		_realExpenses += _payE;
	}
	
}
