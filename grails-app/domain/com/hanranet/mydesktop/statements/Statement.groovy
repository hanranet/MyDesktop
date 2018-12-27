package com.hanranet.mydesktop.statements

import grails.databinding.BindingFormat

class Statement {

    String owner
    String name
    @BindingFormat('MM/dd/yyyy')
    Date beginDate
    @BindingFormat('MM/dd/yyyy')
    Date endingDate
    BigDecimal beginBalance
    BigDecimal endingBalance
    //String createUser
    Date dateCreated
    //String updateUser
    Date lastUpdated
    BigDecimal deposits
    BigDecimal withdrawals


    static transients = ['deposits','withdrawals']

    static constraints = {
        owner(nullable:false)
        name(nullable:false)
        beginDate(nullable:false)
        endingDate(nullable:false)
        beginBalance(nullable:false)
        endingBalance(nullable:false)
    }

    static hasMany = [ debitReceipt: DebitReceipt, creditReceipt: CreditReceipt ]
}
