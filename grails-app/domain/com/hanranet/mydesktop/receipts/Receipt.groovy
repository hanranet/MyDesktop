package com.hanranet.mydesktop.receipts

import java.text.*

class Receipt {

    String owner
    Date date
    Integer checkNo
    String payee
    String category
    BigDecimal debit
    BigDecimal credit
    String memo
    Integer reconcileNo
    String createUser
    Date createDate
    String updateUser
    Date lastUpdate
    BigDecimal balance
    BigDecimal reconcileAmount

    static transients = ['balance','reconcileAmount']

    static constraints = {

        checkNo(nullable:true)
        date(blank:false)
        payee(blank:false)
        category(nullable:true)
        debit(nullable:true)
        credit(nullable:true)
        memo(nullable:true)

        reconcileNo(nullable:true)

    }

    static mapping = {
        sort([date:'asc', debit:'desc'])
        owner defaultValue: "'Cash'"
        date defaultValue: new Date()
        checkNo defaultValue: new Integer("0")
        payee defaultValue: "'Cash'"
        category defaultValue: "'Cash'"
        debit defaultValue: new BigDecimal(0.00)
        credit defaultValue: new BigDecimal(0.00)
        memo defaultValue: "'Cash'"
        checkNo defaultValue: new Integer("0")
        createUser defaultValue: "'thanrahan'"
        createDate defaultValue: new Date()
        updateUser defaultValue: "'thanrahan'"
        lastUpdate defaultValue: new Date()
        balance defaultValue: new BigDecimal(0.00)
        reconcileAmount defaultValue: new BigDecimal(0.00)
    }

    @Override
    public String toString(){

        //DateFormat sdf = new SimpleDateFormat('MM/dd/yyyy', Locale.US)
        //def date = sdf.format(this.date)

        def checkNo = ''
        if (this.checkNo != null) {
            checkNo = this.checkNo
        }

        def payee = this.payee
//        payee = payee.replace(' ','%20')
//        payee = payee.replace('\'','')

        def debit = ''
        if (this.debit != null)	{
            debit = this.debit
        }

        def credit = ''
        if (this.credit != null) {
            credit = this.credit
        }

        return new String("date=" + date + "&checkNo=" + checkNo + "&payee=" + payee + "&debit=" + debit + "&credit="+ credit);
    }

    @Override
    public boolean equals(Object o){

        //if (o == null) return false
        //if (o == this) return true
        //if (!(o instanceof Receipt))return false

        Receipt receipt = (Receipt)o

        if (this.debit == receipt.debit && this.credit == receipt.credit )
        {
            return true
        }
        else
        {
            return false
        }
    }

}
