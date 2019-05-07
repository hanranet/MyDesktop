package com.hanranet.mydesktop.vacation

import grails.databinding.BindingFormat

class PTO {

    String owner
    @BindingFormat('MM/dd/yyyy')
    Date startDate
    @BindingFormat('MM/dd/yyyy')
    Date endDate
    String type
    String days
    String used
    String left

    static transients = ['used', 'left']

    static constraints = {
        owner(nullable:false)
        startDate(blank:false)
        endDate(blank:false)
        type(nullable:false)
        days(nullable:false)
    }

    static mapping = {
        sort([endDate:'asc'])
    }

}
