package com.hanranet.mydesktop.receipts

import grails.databinding.BindingFormat

class Receipt
{
    String owner
    @BindingFormat('MM/dd/yyyy')
    Date date
    Integer checkNo
    String payee
    String category
    BigDecimal debit
    BigDecimal credit
    String memo
    Integer reconcileNo
    String createUser
    Date dateCreated
    String updateUser
    Date lastUpdated
    BigDecimal balance
    BigDecimal reconcileAmount

    static transients = ['balance', 'reconcileAmount']

    static constraints =
    {
        checkNo(nullable:true)
        date(blank:false)
        payee(blank:false)
        category(nullable:true)
        debit(nullable:true)
        credit(nullable:true)
        memo(nullable:true)
        reconcileNo(nullable:true)
    }

    static mapping =
    {
        sort([date:'asc'], debit:'desc')
    }


    @Override
    public String toString() {
        return "Receipt{" +
                "owner='" + owner + '\'' +
                ", date=" + date +
                ", checkNo=" + checkNo +
                ", payee='" + payee + '\'' +
                ", category='" + category + '\'' +
                ", debit=" + debit +
                ", credit=" + credit +
                ", memo='" + memo + '\'' +
                ", reconcileNo=" + reconcileNo +
                ", createUser='" + createUser + '\'' +
                ", dateCreated=" + dateCreated +
                ", updateUser='" + updateUser + '\'' +
                ", lastUpdated=" + lastUpdated +
                ", balance=" + balance +
                ", reconcileAmount=" + reconcileAmount +
                '}';
    }
}
