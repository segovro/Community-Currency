# Community-Currency
A community currency with zero reserve mutual credit and adjustable parameters  
#Theory  
[What the hell is p2p credit](http://desperado-theory.blogspot.be/2015/05/what-hell-is-p2p-credit.html)  
[Moneda con pagos y creditos p2p sin reserva](http://desperado-theory.blogspot.com.es/2015/08/moneda-con-pagos-y-creditos-p2p-sin.html)  
#General  
The currency is supposed to be managed by a community. Nevertheless, the currency can be used by anybody having an ethereum account to perform payment transactions. The community is managed by a DAO at ethereum or outside ethereum, or just run by human relations. The currency contract does not cover how the DAO is managed, the votings and decision mechanisms. 
The currency desing presumes that all monetary decissions of the community are implemented through two trusted accounts:
* the **treasury** account. Creates the currency, sets the basic parameters and deploys it to the blockchain. It can mint and assign amounts of **CCUs** (Community Currency Units).
* the **community** account. Admits or kickouts members. It can mint and assign amounts of **Reputation**. 

**Users** making transfer can be anybody having an ethereum account. **Members**, additionally, can authorize credits to other members. Anybody, including Members may have different ethereum accounts. The community is supposed to have external mechanisms to establish the **identity** of a person, and therefore establish which of his accounts this person prefers to use as the unique account as member.  
#p2p Credits  
Members have a **Reputation** as "Money Lenders". Members can authorise a p2p Credit to another member, with a deadline. Its up to the Money Lender to investigate the borrowers solvency. No tool is provided within the currency contract to analyze the solvency. The system generates the necessary Community Currency Units and adds them to the CCUs balance of the borrower. The Money Lender pays with a **Reputation Cost**. The cost is proportional to the amount and the time of the credit. When the deadline is over:
* if the credit has been returned, and the balance of the borrower is again positive, the Money Lender gets back the Reputation Cost and a reward in Reputation. In the future he will be able to authorize larger credits.
* if the credit has not been returned, and the balance of the borrower is still negative, the Money Lender loses the Reputation Cost and a fine in Reputation. In the future he will be able to authorize only smaller credits.  

#Adjustable Parameters
- **treasury**; the address of the treasury of the DAO. The creator and minter of the currency  
- **community**; the address of the Community account. Where donations and taxes are paid. Account used to pay community works  
- **vatRate**; the depreciation at each transaction. The VAT to be paid to the DAO at the community account. % x 100  
- **rewardRate**; reward Rate to the moneyLender of a successful credit, as a multiplier of the Reputation Cost of the credit. % x 100  

#Functions
##acceptMember
the community account can accept accounts as members  
a community can opt to name the community account as member or not and therefore give credits or not from that account
##kickOutMember
the community acount can kick out members
##mintAssignCCUs
the treasury account can issue as much communityCurrency it likes and send it to any Member  
warning: it increases the monetary mass 
##mintAssignReputation
the community account can issue as much Reputation it likes and send it to any Member 
##transfer
make a payment: anybody can make a payment if he has sufficient CCUs and / or credit  
every payment will update the credit status
##credit
only members can authorize or get a credit
##myWallet
gives you
- myCCUs
- myReputation
- myCredit
- myDeadline
- amIMember



