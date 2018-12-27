package com.hanranet.mydesktop.budget

class Budget {

    String owner
    String categoryName
    BigDecimal monthlyAmount
    String billPayee
    String billDate
    BigDecimal billAmount
    String memo
    String createUser
    Date dateCreated
    String updateUser
    Date lastUpdated
    BigDecimal biWeeklyAmount

    static transients = ['biWeeklyAmount']

    static constraints = {
        categoryName()
        monthlyAmount()
        memo(nullable:true)
        billDate(nullable:true)
        billPayee(nullable:true)
        billAmount(nullable:true)
    }

    String getOwner() {
        return owner
    }

    void setOwner(String owner) {
        this.owner = owner
    }

    String getCategoryName() {
        return categoryName
    }

    void setCategoryName(String categoryName) {
        this.categoryName = categoryName
    }

    BigDecimal getMonthlyAmount() {
        return monthlyAmount
    }

    void setMonthlyAmount(BigDecimal monthlyAmount) {
        this.monthlyAmount = monthlyAmount
    }

    String getBillPayee() {
        return billPayee
    }

    void setBillPayee(String billPayee) {
        this.billPayee = billPayee
    }

    String getBillDate() {
        return billDate
    }

    void setBillDate(String billDate) {
        this.billDate = billDate
    }

    BigDecimal getBillAmount() {
        return billAmount
    }

    void setBillAmount(BigDecimal billAmount) {
        this.billAmount = billAmount
    }

    String getMemo() {
        return memo
    }

    void setMemo(String memo) {
        this.memo = memo
    }

    String getCreateUser() {
        return createUser
    }

    void setCreateUser(String createUser) {
        this.createUser = createUser
    }

    Date getDateCreated() {
        return dateCreated
    }

    void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated
    }

    String getUpdateUser() {
        return updateUser
    }

    void setUpdateUser(String updateUser) {
        this.updateUser = updateUser
    }

    Date getLastUpdated() {
        return lastUpdated
    }

    void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated
    }

    BigDecimal getBiWeeklyAmount() {
        return biWeeklyAmount
    }

    void setBiWeeklyAmount(BigDecimal biWeeklyAmount) {
        this.biWeeklyAmount = biWeeklyAmount
    }

    static getTransients() {
        return transients
    }

    static void setTransients(transients) {
        Budget.transients = transients
    }

    static getConstraints() {
        return constraints
    }

    static void setConstraints(constraints) {
        Budget.constraints = constraints
    }


    @Override
    public String toString() {
        return "Budget{" +
                "owner='" + owner + '\'' +
                ", categoryName='" + categoryName + '\'' +
                ", monthlyAmount=" + monthlyAmount +
                ", billPayee='" + billPayee + '\'' +
                ", billDate='" + billDate + '\'' +
                ", billAmount=" + billAmount +
                ", memo='" + memo + '\'' +
                ", createUser='" + createUser + '\'' +
                ", dateCreated=" + dateCreated +
                ", updateUser='" + updateUser + '\'' +
                ", lastUpdated=" + lastUpdated +
                ", biWeeklyAmount=" + biWeeklyAmount +
                '}';
    }
}
