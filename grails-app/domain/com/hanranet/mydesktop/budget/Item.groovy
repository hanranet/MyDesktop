package com.hanranet.mydesktop.budget

import grails.databinding.BindingFormat

class Item {

    String owner
    String name
    BigDecimal weeklyBucketAmount
    BigDecimal monthlyBucketAmount
    BigDecimal bucketAmount
    String category
    String memo
    @BindingFormat('MM/dd/yyyy')
    Date billDate
    String billPayee
    BigDecimal billAmount
    String createUser
    Date dateCreated
    String updateUser
    Date lastUpdated

    static transients = ["weeklyBucketAmount"]

    static constraints = {
        owner(blank:false, nullable:false)
        name(blank:false, nullable:false)
        category(inList: ["U", "A", "L"])
        monthlyBucketAmount(blank:true, nullable:true)
        bucketAmount(blank:true, nullable:true)
        memo(blank:true, nullable:true)
        billDate(blank:true, nullable:true)
        billPayee(blank:true, nullable:true)
        billAmount(blank:true, nullable:true)
    }

    static mapping = {sort([name:'asc', monthlyBucketAmount:'desc'])}
}
