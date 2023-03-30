/**
 * Created by Jason Simmons
 * Description: Abstract class for all the selectors
 */

 public abstract class SObjects_Selector {

    public Id accountId {get;set;}
    //Property to hold the query that needs to be executed
    protected String soqlQuery {get; set;}
    //Public property to define the fields to be returned (defined as strings)
    public List<String> groupByFieldList {get; set;}
    //Public property to define the fields to sort on (defined as strings)
    public List<String> orderByFieldList {get; set;}
    //Implement this method to inform the base class of the SObject (custom or standard) to be queried
    abstract Schema.SObjectType getSObjectType();

    //Method to return the name of the specified sobject
    @TestVisible
    protected String getSObjectName(){
        return getSObjectType().getDescribe().getName();
    }

    //Constructor
    public SObjects_Selector(){}

    //Public property to define the fields to be returned (defined as strings)
    public List<String> sObjectFieldStringList {private get; set;}
    //Public property to define the WHERE CLAUSE to be returned (defined as string)
    public String sObjectWhereString {private get; set;}

    //Method to create the select string of the query
    @TestVisible
    protected String getSelectString()
    {
        //A list of fields (strings) has been defined, so append the strings and return the string
        if(sObjectFieldStringList != null && !sObjectFieldStringList.isEmpty())
        {
            return String.join(sObjectFieldStringList, ', ');
        } //Otherwise only return the Id
        else return 'Id';
    }

    //Method to create the where string of the query
    @TestVisible
    protected String getWhereString()
    {
        return sObjectWhereString;
 
    }

    //Method to return the order by string
    @TestVisible
    protected String getOrderByString()
    {
        //The order by string has been defined
        if(orderByFieldList!= null && !orderByFieldList.isEmpty())
        {
            //Return the formatted string
            return String.format('ORDER BY {0}', new List<String> { String.join(orderByFieldList, ', ') });
        }
        return '';
    }

    //Method to return the group by string
    @TestVisible
    protected String getGroupByString(){
        //The order by string has been defined
        if(groupByFieldList!= null && !groupByFieldList.isEmpty()){
            //Return the formatted string
            return String.format('GROUP BY {0}', new List<String> { String.join(groupByFieldList, ', ') });
        }
        return '';
    }

    public String returnQuery(){
        return soqlQuery;
    }
}