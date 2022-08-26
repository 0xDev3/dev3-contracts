# Payroll Handler

Payroll Handler can be used to define salaries for multiple wallets and easily automate recurring payments.

## Payroll Definition

One payroll entry consists of following:

- Payee wallet
- Token used as the payment method
- Salary amount
- Time period basis (weekly, monthly, etc.)
- Last payment received (timestamp)

## Adding new payees

To add multiple wallets and register them as a salary receivers, the `addPayrolls()` function must be called with the list of payroll entries provided as a paremeter. Payroll entries are constructed as explained in the previous section.

`Last payment received` field should be configured properly when adding new payrolls as this value (in combination with the `time period basis`) will determine the next payment cycle when the receiver will be able to claim his salary. If `lastPaymentReceived = now()` and `timePeriodBasis = 1 month`, the receiver will be able to claim his first payment exactly after one month has passed, and then every other month after that.

## Removing payees

To remove payees from the list of receivers simply call the `removePayrolls()` function and provide the list of wallets to remove from the system. These wallets will not be able to claim their salaries anymore.

## Claiming salary

To claim salary for a list of wallets, simply call the `claim()` function and provide this list. Provided wallets must be eligible to claim their salaries or else the transaction will fail.

If payee has forgotten to claim his salary for a long time (is this ever going to happen?), he will be able to do so by repeatedly calling the `claim()` function and pulling multiple salaries until the state is properly updated.

## Spending funds

You have to make sure the Payroll Handler is properly funded so that every eligible payee can claim their salaries once they're unlocked or else their attempts to claim the salary will result in a failed transaction.

For example, if you've registered 10 payees, and configured all of them to receive 100 TOKENS on 1st of every month, you need to send at least 1000 TOKENS (10*100) to the Payroll Handler contract in order for all of the payees to be able to claim their next batch of salaries. If the funds available are below 1000 TOKENS, then some of the payees will be able to claim their salary on a first come first serve basis but once the funds are drained the rest of the payees will not be able to claim salary until the contract is funded again.
