/**
 * Test class for the CalculateHelper
 * 
 * @author Richard J Simmons
 * @since Date 30/03/2023.
 */
@IsTest
private class TEST_CalculateHelper {

    static testMethod void testCalculateDistance() {

        Decimal latitude1 = 7.1803574440931515;
        Decimal longitude1 = 79.88425209763032;
        Decimal latitude2 = 41.29761424966808;
        Decimal longitude2 =2.0833155557287997;

        Test.startTest();

        Decimal result = CalculateHelper.calculateDistance(latitude1, longitude1, latitude2, longitude2);

        Test.stopTest();
        
        System.assert(result > 0);
    }
} 