package com.hanranet.mydesktop.vacation

import grails.databinding.BindingFormat

class Event {

    String owner
    @BindingFormat('MM/dd/yyyy')
    Date startDate
    @BindingFormat('MM/dd/yyyy')
    Date endDate
    Integer days
    String comment
    String type

    static constraints = {
        startDate(blank:false)
        days(nullable:false)
        comment(blank:false)
        type(blank:false)
    }

    static mapping = {
        sort([startDate:'asc'])
    }
}
